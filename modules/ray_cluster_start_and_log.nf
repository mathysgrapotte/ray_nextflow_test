process RAY_CLUSTER_START_AND_LOG {
    cpus 6
    memory '12 GB'
    container 'rayproject/ray:latest'
    containerOptions "--user ray --cpus ${task.cpus} --memory=${task.memory.toString().replace(' ', '').replace('GB','g')}"
    publishDir 'results/', mode: 'copy'

    output:
    path "ray_logs.txt", emit: ray_logs

    script:
    """

    # activate conda environment
    # source /home/ray/anaconda3/bin/activate base

    # Start Ray head node
    ray start --head --port=6379 > ray_logs.txt
    
    sleep 10

    # Get Ray status and append to logs
    ray status >> ray_logs.txt

    # run check_ray.py
    check_ray.py >> ray_logs.txt

    # Stop Ray cluster and append to logs
    ray stop
    """
}
