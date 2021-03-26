import subprocess
import sys

reg = 'docker.mirrors.ustc.edu.cn'
#  reg = 'dockerhub.azk8s.cn'


def main():
    args = sys.argv
    if len(args) != 2:
        raise Exception("args != 1")

    origin_image = get_image(args[1])
    proxy_image = '{}/{}'.format(reg, origin_image)

    cmd = "docker pull {}".format(origin_image)
    run(cmd)

    cmd = "docker tag {} {}".format(proxy_image, origin_image)
    run(cmd)


def get_image(origin_image):
    # TODO: k8s.gcr.io  gcr.io quay.io
    library = ''
    image = ''
    tag = 'latest'

    image_tag = ''

    image_split = origin_image.split('/')

    if len(image_split) == 1:
        library = 'library'
        image_tag = image_split[0]
    elif len(image_split) == 2:
        library = image_split[0]
        image_tag = image_split[1]
    else:
        raise Exception("Image Error")

    image_tag_split = image_tag.split(":")
    if len(image_tag_split) == 1:
        image = image_tag_split[0]
    elif len(image_tag_split) == 2:
        image = image_tag_split[0]
        tag = image_tag_split[1]
    else:
        raise Exception("Image Error")

    return '{}/{}:{}'.format(library, image, tag)


def run(cmd):
    print(cmd)
    result = subprocess.run(cmd, capture_output=True, shell=True, check=True)
    print(str(result.stdout, encoding='utf-8'))


if __name__ == '__main__':
    main()
