The development shall take place at 3 different stages:

- Development Stage:
Local development envirnment local to the developer with replication of resources needed to run the software: Notably a private AWS envirnment should be deployed for experimentation in order to not break production or staging envirnments.
- Staging stage:
Features or fixes made and tested locally by the developer should be deployed here in a shareable envirnment (website and backend available publicly) in order to be tested by users of the app.
- Production stage:
Is the public facing deployment of the software and shouldn't be changed (deployed to) unless the features/fixes were accepted to be running with no issues by the users.
