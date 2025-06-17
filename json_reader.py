### short script for reading json files ###
import json
import os
import argparse

def read_json(json_file):
    with open(json_file, 'r') as f:
        data = json.load(f)
    return data

def parse_args():
    parser = argparse.ArgumentParser(description='Read json file')
    parser.add_argument('--json_file', type=str, help='path to json file')
    return parser.parse_args()

def main():
    args = parse_args()
    data = read_json(args.json_file)
    for entry in data:
        for key, value in entry.items():
            if key == 'name':
                print(f'{value}')

if __name__ == '__main__':
    main()