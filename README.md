# Hangbot

You've found HangOps friendly Chat Robot Hangbot

### Docker

Hangbot will now run within a docker container. If you do this, you will need to `rm -r node_modules` as the locally installed modules will often conflict with the Docker (linux) runtime.

1.  Edit `.env` to fit your needs, it defaults to a docker-compose redis instance. `cp .env.sample .env` would be a fine places to start modifying $ENV to suit your needs
2.  `cp docker-compose.override{.example,}.yml docker-compose.yml` combined with step one will help you get your container up with your custom ENV
3.  Then you can run either:
  * `make run` to run a real hangbot instance, connected to slack, your slack token is required to be set in `.env`
  * `make interactive` or simply `make` to run in interactive mode, which does not connect to slack.

### Terraform

This will build absolutely *everything* you'll need to run an EKS cluster, it was borrowed almost entirely from: https://learn.hashicorp.com/terraform/aws/eks-intro - its assumed you know enough to get an EKS cluster running

1. If you have [tfenv](https://github.com/tfutils/tfenv) setup do: `tfenv install 0.11.11` and `tfenv use 0.11.11`
2. `terraform init`
3. `terraform plan --out tfenv.plan`
4. `terraform apply`

### EKS

Presuming you've got an EKS cluster setup and working, you can get things kicked off by setting an ENVAR for `HUBOT_SLACK_TOKEN` on your deployment machine. 

Next, do something like this: `kubectl create secret generic hangbot-secret --from-literal=HUBOT_SLACK_TOKEN=<your-slack-token>` 

Now let's deploy!

1. `kubectl apply -f redis-deployment.yaml`
2. `kubectl apply -f app-deployment.yaml`
3. verify its running! `kubectl get pods`

Should look like this!

```
your@machine:~$ kubectl get pods
NAME                       READY   STATUS    RESTARTS   AGE
hangbot-6fc4b6d85b-m4tjb   1/1     Running   0          14s
redis-7977ffc58f-v6wrg     1/1     Running   0          6s
```
Hope into your Slack and give it a whirl:

`gdoc @yourusername`

should spit back the reminder!