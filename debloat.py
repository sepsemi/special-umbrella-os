from pathlib import Path

packages_path = Path('/var/home/user/development/sboms/secureblue_nvidia_silverblue_packages_2.txt')
debloated_packages_path = Path(
    '/var/home/user/development/personal/atomic-os-custom-testing/debloated.txt')


def open_file_and_get_lines(path):
    with open(path, 'r') as fp:
        return [line.strip() for line in fp.readlines()]


debloated_packages = set()
for line in open_file_and_get_lines(debloated_packages_path):
    if '#' in line:
        continue

    package_name = line.split('.')[0]
    package_name = package_name[1:].lstrip()

    # print(package_name)
    debloated_packages.add(package_name)

package_count = 0
packages_remaining = set()
for package in open_file_and_get_lines(packages_path):
    if 'font' in package:
        continue

    is_bloated = False

    for name in debloated_packages:
        if len(name) < 1:
            continue

        if name in package:
            is_bloated = True
            break

    if is_bloated is True:
        continue

    package_count += 1
    packages_remaining.add(package)
    print(package_count, package)

with open('filtered_packages.txt', 'w') as fp:
    for line in packages_remaining:
        fp.write(line.strip() + '\n')
