### Goal:
The goal of this exercise is to create a shell script that displays the number of failed login attempts by IP address and location.

### Scenario:
One day you received a call about a user being locked out of their account.  Being the awesome sysadmin that you are, you decided to look at the log files to see why this person's account was locked.  While doing so, you happened to notice hundreds thousands of failed login attempts!

You decide you need a way to quickly summarize the failed login attempts.  That way you can quickly decide if an IP address needs to blocked.

### Shell Script Requirements:
You think about what the shell script must do and how you would like it operate.  You come up with the following list.

### The script:

- [ ] Is named "show-attackers.sh".

- [ ] Requires that a file is provided as an argument.  If a file is not provided or it cannot be read, then the script will display an error message and exit with a status of 1.

- [ ] Counts the number of failed login attempts by IP address.  If there are any IP addresses with more than 10 failed login attempts, the number of attempts made, the IP address from which those attempts were made, and the location of the IP address will be displayed.

- [ ] Hint: use the geoiplookup command to find the location of the IP address.

- [ ] Produces output in CSV (comma-separated values) format with a header of "Count,IP,Location".
