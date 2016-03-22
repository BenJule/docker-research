基于 node 官方镜像安装 vim sshd cnpm
============

用法
-----

    docker build -t zysam/node-ssh .

		docker run -d --name node-dev -p 8822:22 -p 13000-13008:3000-3008 -e ROOT_PASS="123456" zysam/node-ssh

### 问题
	如果无法ssh, 还得修改 sshd_config 配置
	PermitRootLogin without-password
	PermitRootLogin yes
	
运行结果
---

You will see an output like the following:

	========================================================================
	You can now connect to this Debian container via SSH using:

	    ssh -p <port> root@<host>
	and enter the root password 'U0iSGVUCr7W3' when prompted

	Please remember to change the above password as soon as possible!
	========================================================================

In this case, `U0iSGVUCr7W3` is the password allocated to the `root` user.

Done!


Setting a specific password for the root account
------------------------------------------------

If you want to use a preset password instead of a random generated one, you can
set the environment variable `ROOT_PASS` to your specific password when running the container:

	docker run -d --name test -v /home/docker:/home -p 12022:22 -p 18001:8001 -e ROOT_PASS="123456" sam/node


Adding SSH authorized keys
--------------------------

If you want to use your SSH key to login, you can use the `AUTHORIZED_KEYS` environment variable. You can add more than one public key separating them by `,`:

    docker run -d -p 2222:22 -e AUTHORIZED_KEYS="`cat ~/.ssh/id_rsa.pub`" tutum/debian:latest
