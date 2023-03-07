### Goal:
The goal of this exercise is to create a shell script that adds users to the same Linux system as the script is executed on.  Additionally this script will conform to Linux program standard conventions.

### Scenario:
The help desk team loves the script you created for them.  However, they have just one more request.  They want the script to only display the details that they need to send to the user after they create their account.

You decide that's an easy enough change.  Because you know you'll have to use redirection to accomplish the task, you decide add redirection in other places in the script to make it conform to standard UNIX/Linux program conventions.  Namely, sending errors to STDERR.

### Shell Script Requirements:
You have your requirements from the "add-new-local-user.sh" script you created.  You decide to use those as the basis for your new requirements.  You come up with the following list.

### The script:

- [ ] Is named "add-newer-local-user.sh".  (You change the name slightly to distinguish it from the previous script.  NOTE: In the real world you could have easily kept the same script name.  I just want to use a different name for the purpose of discussing specific scripts in the class.)

- [ ] Enforces that it be executed with superuser (root) privileges.  If the script is not executed with superuser privileges it will not attempt to create a user and returns an exit status of 1.  All messages associated with this event will be displayed on standard error.

- [ ] Provides a usage statement much like you would find in a man page if the user does not supply an account name on the command line and returns an exit status of 1.  All messages associated with this event will be displayed on standard error.

- [ ] Uses the first argument provided on the command line as the username for the account.  Any remaining arguments on the command line will be treated as the comment for the account.

- [ ] Automatically generates a password for the new account.

- [ ] Informs the user if the account was not able to be created for some reason.  If the account is not created, the script is to return an exit status of 1.  All messages associated with this event will be displayed on standard error.

- [ ] Displays the username, password, and host where the account was created.  This way the help desk staff can copy the output of the script in order to easily deliver the information to the new account holder.

- [ ] Suppress the output from all other commands.
