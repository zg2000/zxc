##### 设置系统环境变量

#terraform start
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export TF_VAR_aws_account_id=
#terraform end

#### M1芯片的Mac需要执行以下命令

https://discuss.hashicorp.com/t/template-v2-2-0-does-not-have-a-package-available-mac-m1/35099/7

brew install kreuzwerker/taps/m1-terraform-provider-helper
m1-terraform-provider-helper activate
m1-terraform-provider-helper install hashicorp/template -v v2.2.0
terraform init --upgrade

##### 初始化工作目录和配置

terraform init

##### 创建或更新基础设施：

terraform apply

##### 显示当前状态：

terraform show

##### 打印执行计划：

terraform plan

##### 销毁基础设施：

##### terraform destroy

##### 列出资源：

terraform state list

##### 根据指定的模块进行操作：

terraform get

##### 校验配置文件：

terraform validate

##### 输出基础设施信息：

terraform output

##### 强制更新指定的资源：

terraform taint

#### 导入资源

terraform import module.msk_instance.module.front_msk_instance.aws_security_group.this[0] sg-03a66ca7280dc31e5 

#### 删除资源
terraform state rm module.security_group.aws_security_group.aws_zd_vdp_flink_sg

Terraform加载变量值的顺序是：

环境变量
terraform.tfvars文件(如果存在的话)
terraform.tfvars.json文件(如果存在的话)
所有的.auto.tfvars或者.auto.tfvars.json文件，以字母顺序排序处理
通过-var或是-var-file命令行参数传递的输入变量，按照在命令行参数中定义的顺序加载


##### 相关资料
arn: Amazon Resource Name（ARN）唯一标识 AWS 资源。当您需要在 AWS 全局环境中（比如 IAM policy、Amazon Relational Database Service (Amazon RDS) 标签和 API 调用中）明确指定一项资源时，我们要求使用 ARN。
以下是 ARN 的一般格式。特定格式取决于资源。要使用 ARN，请将斜体 文本替换为特定于资源的信息。请注意，某些资源的 ARN 忽略了区域、账户 ID 或同时忽略了这两者。


arn:partition:service:region:account-id:resource-id
arn:partition:service:region:account-id:resource-type/resource-id
arn:partition:service:region:account-id:resource-type:resource-id
partition
资源所在的分区。分区 是一组 AWS 区域。每个 AWS 账户的作用域为一个分区。

以下是支持的分区：

aws - AWS 区域

aws-cn – 中国区域

aws-us-gov - AWS GovCloud (US) 区域

service
标识 AWS 产品的服务命名空间。

region
区域代码。例如，us-east-2 代表美国东部（俄亥俄）。有关区域代码的列表，请参阅《AWS 一般参考》中的 区域端点。

account-id
拥有资源的 AWS 账户的 ID（不含连字符）。例如，123456789012。

resource-type
资源类型。例如，虚拟私有云（VPC）的 vpc。

resource-id
资源标识符。这是资源的名称、资源的 ID 或资源路径。某些资源标识符包括父资源 (sub-resource-type/parent-resource/sub-resource) 或限定符（例如版本）(resource-type:resource-name:qualifier)。

示例
IAM 用户
arn:aws:iam::123456789012:user/johndoe

SNS 主题
arn:aws:sns:us-east-1:123456789012:example-sns-topic-name

VPC
arn:aws:ec2:us-east-1:123456789012:vpc/vpc-0e9801d129EXAMPLE



AWS Identity and Access Management (IAM) 是 AWS 的一项服务，用于管理对 AWS 资源的访问权限。AWS IAM 角色（AWS IAM Role）是一种 AWS 资源，用于定义一组权限，这些权限可以分配给 AWS 资源或 AWS 用户。IAM 角色通常用于临时授权，例如允许 EC2 实例访问其他 AWS 服务或资源，或者允许 AWS Lambda 函数执行特定的操作。

IAM 角色通常用于以下场景：

1. **跨账户访问**: 允许一个 AWS 账户中的资源访问另一个 AWS 账户中的资源。
2. **AWS 服务访问**: 允许 AWS 服务执行特定操作，例如允许 EC2 实例访问 S3 存储桶。
3. **临时凭证分配**: 通过将角色分配给 EC2 实例或 Lambda 函数等服务，可以避免在代码中硬编码密钥，提高安全性。

在 Terraform 中配置 IAM 角色通常涉及以下步骤：

1. **创建 IAM 角色**: 使用 Terraform 的 `aws_iam_role` 资源来定义 IAM 角色及其权限。
2. **定义信任关系**: 在 IAM 角色中，需要定义一个信任策略，指定哪些 AWS 资源可以扮演这个角色。这通常通过 `assume_role_policy` 属性来完成。
3. **附加权限策略**: 可以将附加的权限策略（即 AWS 中的 IAM 策略）与角色关联，以定义角色的具体权限。
4. **使用角色**: 在需要使用角色的 AWS 服务中，将角色分配给该服务，以授权其执行特定的操作。

以下是一个简单的示例，演示如何使用 Terraform 配置一个 IAM 角色：

```hcl
provider "aws" {
  region = "us-west-2"
}

resource "aws_iam_role" "example_role" {
  name               = "example-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "example_attachment" {
  name       = "example-attachment"
  roles      = [aws_iam_role.example_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
```

在这个示例中：

- 创建了一个名为 `example-role` 的 IAM 角色，并定义了一个信任策略，允许 EC2 实例扮演该角色。
- 使用 `aws_iam_policy_attachment` 资源，将名为 `AmazonS3ReadOnlyAccess` 的 AWS 托管策略附加到角色上，赋予角色只读访问 S3 的权限。

通过这样的配置，您可以创建一个具有特定权限的 IAM 角色，然后将其分配给需要访问这些权限的 AWS 服务或资源。


AWS Identity and Access Management (IAM) 中的 IAM 组（AWS IAM Group）是一种逻辑组合，用于集中管理 AWS 用户的权限。IAM 组允许您将一组 IAM 用户组织在一起，并为他们分配相同的权限。这样，您可以更轻松地管理用户的权限，而不必为每个用户单独分配权限。

IAM 组的主要功能和作用包括：

1. **简化权限管理**：您可以将相似权限的用户组织成组，并为整个组分配权限，而不必为每个用户单独分配权限。这样可以简化权限管理，并确保一致性和可管理性。

2. **批量管理**：通过向 IAM 组添加或移除用户，可以轻松地批量管理用户的权限。一旦权限被分配给组，新加入组的用户将自动继承该组的权限。

3. **易于跟踪**：通过 IAM 组，您可以更容易地跟踪哪些用户拥有哪些权限，因为权限是针对组进行管理的。

在 Terraform 中配置 IAM 组通常包括以下步骤：

1. **创建 IAM 组**：使用 Terraform 的 `aws_iam_group` 资源来定义 IAM 组。

2. **添加 IAM 用户到组中**：使用 `aws_iam_group_membership` 资源将 IAM 用户添加到组中。

下面是一个简单的示例，演示如何使用 Terraform 配置一个 IAM 组：

```hcl
provider "aws" {
  region = "us-west-2"
}

resource "aws_iam_group" "example_group" {
  name = "example-group"
}

resource "aws_iam_user" "example_user1" {
  name = "example-user1"
}

resource "aws_iam_user" "example_user2" {
  name = "example-user2"
}

resource "aws_iam_group_membership" "example_membership_user1" {
  name  = "example-membership-user1"
  users = [aws_iam_user.example_user1.name]
  group = aws_iam_group.example_group.name
}

resource "aws_iam_group_membership" "example_membership_user2" {
  name  = "example-membership-user2"
  users = [aws_iam_user.example_user2.name]
  group = aws_iam_group.example_group.name
}
```

在这个示例中：

- 创建了一个名为 `example-group` 的 IAM 组。
- 创建了两个 IAM 用户：`example-user1` 和 `example-user2`。
- 使用 `aws_iam_group_membership` 资源，将 `example-user1` 和 `example-user2` 用户添加到 `example-group` 组中。

通过这样的配置，您可以创建一个 IAM 组，并将需要相同权限的用户组织在一起。然后，您可以将权限分配给整个组，而不必为每个用户单独分配权限。



=====================
AWS 的安全组（Security Group）是一种虚拟防火墙，用于控制 AWS 实例的入站和出站流量。安全组作为实例级别的防火墙，用于过滤网络流量。您可以为实例关联一个或多个安全组，以控制与该实例的通信规则。

安全组的主要功能和作用包括：

1. **网络流量控制**：安全组允许您定义入站和出站流量的规则，控制哪些类型的流量允许进入或离开实例。

2. **灵活的规则定义**：您可以根据 IP 地址、协议和端口号等标准定义安全组规则，以满足特定的网络安全需求。

3. **动态调整**：安全组的规则是动态的，可以根据需要随时更改。这使得您可以根据实际需求及时调整网络访问权限。

4. **与实例关联**：安全组是与实例关联的，因此您可以根据实例的角色和功能，为不同的实例应用不同的网络访问控制规则。

在 Terraform 中配置安全组通常涉及以下步骤：

1. **创建安全组**：使用 Terraform 的 `aws_security_group` 资源来定义安全组及其规则。

2. **定义入站和出站规则**：使用 `ingress` 和 `egress` 块在安全组中定义入站和出站流量的规则。您可以指定允许的 IP 地址范围、协议和端口号等信息。

3. **关联安全组**：在创建或配置 AWS 实例时，将安全组与实例关联，以应用所定义的安全组规则。

下面是一个简单的示例，演示如何使用 Terraform 配置一个安全组：

```hcl
provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "example_security_group" {
  name        = "example-security-group"
  description = "Example security group for web server"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

在这个示例中：

- 创建了一个名为 `example-security-group` 的安全组。
- 在安全组中定义了一个入站规则，允许 TCP 协议的流量从任何来源 IP 地址的端口 80 进入。
- 定义了一个出站规则，允许 TCP 协议的流量从安全组关联的实例出去，目的地端口范围是 0 到 65535，并允许流量发送到任何目标 IP 地址。

通过这样的配置，您可以创建一个具有特定网络访问控制规则的安全组，并将其关联到需要该规则的实例上。


--------------------------------------------------------------------
在 AWS 中，安全组（Security Group）和安全组规则（Security Group Rule）是两个相关但不同的概念。它们之间的区别如下：

1. **安全组（Security Group）**：
    - 安全组是一种虚拟防火墙，用于控制 AWS 实例的入站和出站流量。
    - 安全组是与实例关联的，每个实例可以关联一个或多个安全组。
    - 安全组规定了允许或拒绝流量通过实例的规则。
    - 安全组是实例级别的防火墙，因此其规则适用于实例上的所有流量。

2. **安全组规则（Security Group Rule）**：
    - 安全组规则是安全组中定义的单个访问规则，用于控制入站或出站流量。
    - 每个安全组可以有多个安全组规则，每个规则定义了特定类型的流量允许或拒绝的条件。
    - 安全组规则通常指定了流量的来源 IP 地址范围、协议、端口范围等信息。
    - 安全组规则用于指定允许或拒绝特定类型的流量通过安全组的规则。

总的来说，安全组是一种实体，它定义了一组安全规则，而安全组规则是定义了安全组中流量访问控制的具体规则。安全组规则是安全组的组成部分，用于实现对实例流量的细粒度控制。