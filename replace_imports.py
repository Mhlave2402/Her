import os

def replace_in_file(file_path, old_str, new_str):
    with open(file_path, 'r') as file:
        content = file.read()
    content = content.replace(old_str, new_str)
    with open(file_path, 'w') as file:
        file.write(content)

def process_directory(directory, old_str, new_str):
    for dirpath, _, filenames in os.walk(directory):
        for filename in filenames:
            if filename.endswith('.dart') or filename.endswith('.yaml'):
                file_path = os.path.join(dirpath, filename)
                replace_in_file(file_path, old_str, new_str)

process_directory('Her user app', 'shego_user_app', 'her_user_app')
process_directory('Her driver app', 'ride_sharing_user_app', 'her_driver_app')
process_directory('Her driver app', 'shego_driver_app', 'her_driver_app')
process_directory('.', 'Shego', 'Her')
process_directory('.', 'shego', 'her')

print("Replacements complete.")
