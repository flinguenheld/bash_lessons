### Goal:
The goal of this exercise is to create a shell script that executes a given command on multiple servers.

### Scenario:
The number of systems you manage is growing and you need a way to quickly execute the exact same command on all of your systems.  Because it takes too much of your time to type the same command on every single system you manage, you decide to write a script that will do this for you.

### Shell Script Requirements:
You think about what the shell script must do and how you would like it operate.  You come up with the following list.

### The script:

- [ ] Is named "run-everywhere.sh".

- [ ] Executes all arguments as a single command on every server listed in the /vagrant/servers file by default.

- [ ] Executes the provided command as the user executing the script.

- [ ] Uses "ssh -o ConnectTimeout=2" to connect to a host.  This way if a host is down, the script doesn't hang for more than 2 seconds per down server.

- [ ] Allows the user to specify the following options:

- -f FILE  This allows the user to override the default file of /vagrant/servers.  This way they can create their own list of servers execute commands against that list.

- -n  This allows the user to perform a "dry run" where the commands will be displayed instead of executed.  Precede each command that would have been executed with "DRY RUN: ".

- -s Run the command with sudo (superuser) privileges on the remote servers.

- -v Enable verbose mode, which displays the name of the server for which the command is being executed on.

- [ ] Enforces that it be executed without superuser (root) privileges.  If the user wants the remote commands executed with superuser (root) privileges, they are to specify the -s option.

- [ ] Provides a usage statement much like you would find in a man page if the user does not supply a command to run on the command line and returns an exit status of 1.  All messages associated with this event will be displayed on standard error.

- [ ] Informs the user if the command was not able to be executed successfully on a remote host.

- [ ] Exits with an exit status of 0 or the most recent non-zero exit status of the ssh command.


--
### Docker

Install the ssh server:

    apt update && apt-get install -y openssh-server
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

    service ssh start && bash

Add a user:

    useradd --create-home bob
    echo bob:test01234 | chpasswd
