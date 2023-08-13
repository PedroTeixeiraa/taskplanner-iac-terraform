# Projeto Terraform: TaskPlanner - Backend e Frontend

Este projeto Terraform visa criar uma aplicação completa chamada "TaskPlanner". O projeto engloba tanto o backend quanto o frontend, sendo executado na infraestrutura da AWS. A aplicação backend é composta por serviços ECS, RDS, um Load Balancer e configurações DNS no Route53. Por sua vez, o frontend utiliza recursos S3, CloudFront e também configurações DNS no Route53.

## Requisitos

- Terraform instalado
- Credenciais de acesso à AWS configuradas
- Código da Aplicação Backend
- Código da Aplicação Frontend
- Certificado AWS Certificate Manager (ACM) válido
- Hosted zone configurada no Route53

## Configuração do Backend

1. Acesse a pasta "/backend".
2. Execute `terraform init` para inicializar o projeto.
3. Renomeie o arquivo `env/example.tfvars` para `env/backend.tfvars` e preencha os valores necessários.
4. **Nota importante**: Certifique-se de gerar uma imagem Docker do código da aplicação e registrá-la no ECR. O código-fonte está disponível [AQUI](https://github.com/PedroTeixeiraa/taskplanner-api).
5. Execute o seguinte comando para criar os recursos do backend:

```shell
terraform apply -var-file=env/backend.tfvars
```

### Variáveis (Backend)

Aqui estão as variáveis usadas para configurar o backend do projeto:

- `aws_region`: A região da AWS onde os recursos serão provisionados.
- `container_definitions`: Definições de container JSON para a tarefa ECS.
- `task_execution_role_arn`: ARN da função IAM que permite ao ECS executar tarefas em seu nome.
- `task_role_arn`: ARN da função IAM que permite que os containers na tarefa chamem os serviços da AWS em seu nome.
- `task_network_mode`: O modo de rede a ser usado para a tarefa ECS.
- `requires_compatibilities`: Um conjunto de tipos de lançamento exigidos pela tarefa.
- `task_cpu`: Unidades de CPU para a tarefa ECS.
- `task_memory`: Memória (em MiB) para a tarefa ECS.
- `service_desired_count`: Número desejado de tarefas para serem executadas no serviço.
- `certificate_arn`: ARN do AWS Certificate Manager.
- `route53_zone_id`: ID da zona do Route 53 hospedada.
- `route53_record_name`: Nome do registro DNS para o registro do Route 53 (por exemplo, myapp.example.com).


## Configuração do Frontend

1. Acesse a pasta "/frontend".
2. Execute `terraform init` para inicializar o projeto.
3. Preencher o arquivo env/example.tfvars com os valores necessários.
4. **Nota importante**: Certifique-se de executar `npm run build` para o projeto frontend e fazer o upload dos arquivos resultantes para o bucket S3 configurado. O código-fonte do frontend está disponível [AQUI](https://github.com/PedroTeixeiraa/taskplanner-web).
5. Execute o seguinte comando para criar os recursos do frontend:

```shell
  terraform apply -var-file=env/frontend.tfvars
```

### Variáveis (Frontend)

Aqui estão as variáveis usadas para configurar o frontend do projeto:

- `aws_region`: A região da AWS onde os recursos serão provisionados.
- `bucket_name`: O nome do Bucket S3
- `certificate_arn`: O ARN do Certificado AWS (ACM).
- `route53_zone_domain`: O domínio base da zona no Route53.
- `cdn_domain`: O domínio onde você deseja implantar a distribuição CloudFront (deixe vazio para implantar no domínio base).

## Estrutura do Projeto

A estrutura deste projeto é organizada da seguinte maneira:

- `backend/`: Contém os recursos da aplicação backend.
- `frontend/`: Contém os recursos da aplicação frontend.
- `backend/env/ e frontend/env/`: Inclui arquivos de exemplo de variáveis para diferentes ambientes.

## Contribuição

Contribuições são bem-vindas! Se você quiser colaborar, sinta-se à vontade para abrir issues ou enviar pull requests.

## Licença

Este projeto é licenciado sob a Licença XYZ. Veja o arquivo [LICENSE](https://github.com/PedroTeixeiraa/taskplanner-iac-terraform/blob/master/LICENSE) para detalhes.

## Contato

Se tiver alguma dúvida ou precisar de suporte, entre em contato pelo email: pedroteixeiraalves007@gmail.com
