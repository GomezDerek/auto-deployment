Purpose
=======
This project aims to develop a bash script that will streamline [Veida AI's](https://veidaai.com/) product deployment.

Problem
=======
[Veida AI's](https://veidaai.com/) deployment process is tedious and annoying. 
Its development instance is hosted in one repository. However, its deployment instance is hosted in two repositories
- a front-end repo connected to Vercel
- a back-end repo connected to Railway

> When deploying, we must 
> 1. copy the dev repo's front-end folder into the Vercel prod repo
> 2. copy the dev repo's back-end folder into the Railway prod repo
> 3. Replace all of our dev repo's DB API calls with Railway's API calls by 
>     a. copying and pasting the API links into Visual Studio's search and replace feature

Solution
========
This custom script will automate deployment.

Directory paths and API paths will be stored in a file so *they only have to be written once.*

After paths are set, simply running `bash deploy.sh` will execute deployment steps 1, 2, & 3.

YEEEEHAWWWWWW