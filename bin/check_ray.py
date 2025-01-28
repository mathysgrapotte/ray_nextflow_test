#!/usr/bin/env python3

import ray
import sys

def main() -> int:
    try:
        # Try to connect to existing Ray cluster
        ray.init(address='auto')
        
        # Get cluster resources and print to stdout
        resources = ray.cluster_resources()
        print(resources)
        return 0
        
    except ConnectionError:
        print("Error: Could not connect to Ray cluster. Please ensure a Ray cluster is running.", file=sys.stderr)
        return 1

if __name__ == '__main__':
    sys.exit(main())

