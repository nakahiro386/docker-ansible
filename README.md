# docker-ansible
Running Ansible inside Docker container

## Usage
1. create .env file
    ```sh
    $ cp dotenv.sample .env
    ```
1. Edit .env file
1. Build docker image
    ```sh
    $ docker compose build --no-cache --pull bash
    ```
1. Check
    ```sh
    $ docker compose run --rm playbook-check
    ```
1. Run
    ```sh
    $ docker compose run --rm playbook
    ```

## License
MIT

## Author
nakahiro386
