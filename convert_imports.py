import os
import re

def replace_imports_in_file(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            content = file.read()
        
        # Replace all instances of ride_sharing_user_app with shego_user_app
        new_content = re.sub(
            r'package:ride_sharing_user_app', 
            'package:shego_user_app', 
            content
        )
        
        if new_content != content:
            with open(file_path, 'w', encoding='utf-8') as file:
                file.write(new_content)
            return True
        return False
    except Exception as e:
        print(f"Error processing {file_path}: {str(e)}")
        return False

def main():
    project_dir = "Shego user app"
    file_count = 0
    changed_files = 0
    
    for root, _, files in os.walk(project_dir):
        for file in files:
            if file.endswith('.dart'):
                file_path = os.path.join(root, file)
                file_count += 1
                if replace_imports_in_file(file_path):
                    changed_files += 1
    
    print(f"Processed {file_count} Dart files")
    print(f"Updated imports in {changed_files} files")

if __name__ == "__main__":
    main()
