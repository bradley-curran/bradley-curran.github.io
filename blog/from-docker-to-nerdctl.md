# Moving from docker to nerdctl on macOS

## TL;DR:

```
brew install lima
limactl start template://default
nerdctl.lima run --rm -it ubuntu:latest
```

## Overview

If you've worked with docker on macOS, you've probably used Docker Desktop. 
It's an all-in-one solution for working with images and containers on macOS. 
While Docker Desktop is great to get started with containers, it hides a lot of
the internals. Now that I'm doing a deep dive on docker, I thought it was time
to upgrade.

Let's back up and explain how docker works. When you use `docker` on the command
line, you're using the docker client. The client interacts with `dockerd`, the
docker server. `dockerd` interacts with the linux container APIs. 

macOS doesn't natively support container APIs, so how can we use containers in 
macOS? We have to run linux somehow. Typically, you'll run a linux virtual
machine on macOS, then run the containers inside the linux VM. 

We need to configure a linux VM on our mac. There's a bunch of ways to do this,
but the method I've found easiest, while still maintaining low-level control is 
`lima`. It uses QEMU to run linux virtual machines on mac. 

## Setting up lima

Install `brew` if you haven't already. Install lima using brew: 

```
brew install lima
```

This will add two commands, `lima` and `limactl`. `limactl` is used to manage
VMs and `lima` is used to shell into the VMs. 

Verify that the lima installed: 

```
limactl ls
WARN[0000] No instance found. Run `limactl start` to create an instance.
```

We don't have any VMs installed, so let's install one: 

```
limactl start template://default

? Creating an instance "default"  [Use arrows to move, type to filter]
> Proceed with the current configuration
  Open an editor to review or modify the current configuration
  Choose another example (docker, podman, archlinux, fedora, ...)
  Exit
```

Proceed with the current configuration. This will download and startup a VM
configured to manage containers. 

**Note:** You can see the example configurations available to you
[on GitHub](https://github.com/lima-vm/lima/tree/master/examples) or 
`/usr/local/share/lima/examples/`. 

You should now be able to shell into the VM:

```
lima
```

Or if you want to type more characters (they both do the same thing): 

```
limactl shell default
```

This should open a shell on the VM. 

## I have a VM, but I wanted to do container things

We still need a way to interact with the lima VM. The `docker` client interacts 
with `dockerd` over a unix socket. But lima uses `containerd` instead of 
`dockerd`. So we need to run an alternative docker client. Fortunately, lima 
comes with a client called `nerdctl`. The CLI is very close to the existing 
`docker` CLI, which makes migration really easy. 

```
lima nerdctl images
```

The above is SSHing into your lima VM, running `nerdctl images`, and printing 
the output. You can use the `nerdctl.lima` command as an alternative too: 

```
nerdctl.lima images
```

I like to alias nerdctl to nerdctl.lima in my shell to make things a little 
easier:

```
# in my .zshrc
alias nerdctl='nerdctl.lima'
```

Now you can finally start using containers! 

```
nerdctl run --rm -it ubuntu:latest
...
elapsed: 22.5s
root@d5d2eb94204a:/# echo 'hello world!'
hello world!
```

Now you can work with containers and have a lot more control over the system
that runs the containers. Happy hacking!

## References

- Lima [https://github.com/lima-vm/lima](https://github.com/lima-vm/lima)
- containerd [https://containerd.io/](https://containerd.io/)
- nerdctl [https://github.com/containerd/nerdctl](https://github.com/containerd/nerdctl)
