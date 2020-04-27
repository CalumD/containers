# Containers
My collection of Docker containers.

This project aims to collect all of my Dockerfiles in one place.
They are specifically aimed at being deployed on my local Unraid server.
That is why most of the containers which need remote access can be given standard / same ports (because I am allocating them a static IP on the docker bridge network).

Each Folder contains the Dockerfile and the script to run at startup.
The unraid-templates folder contains the collection of xml files which Unraid uses to parse the GUI for each docker container.
Along with a template file which I use to create all of the other xmls from.

To use this project, clone it into a local director, then cd into the folder for the container you want to run, then build the Dockerfile.

Or to use the project as part of your unraid installation
- Go to the Docker tab, Scroll to the bottom
- Click into the template-repositories box and hit enter to go onto a new line
- Copy and paste the link to this project (https://github.com/CalumD/containers)
- Click save.

You can then click "Add Container" and all of these containers will become available in the template dropdown.
