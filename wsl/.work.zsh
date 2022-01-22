export LANG=en_US.UTF-8

if [[ "$(< /proc/sys/kernel/osrelease)" == *microsoft* ]]; then
    export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)
fi
