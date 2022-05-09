# Mini-Devops
## AWS-Terraform Study
### ECS를 활용한 웹 어플리케이션 배포
---
### 1. Architecture
![Untitled Diagram drawio (1)](https://user-images.githubusercontent.com/49158155/167415054-5693f60a-7ceb-4ff4-82d2-6933622dcb2e.png)

### 2. Explanation
1. VPC : public subnet, private subnet 2개, Nat Gateway
    - public subnet : NAT Gateway, Bastion instance
    - private subnet : ECS
2. Bastion Instance
    - public subnet에 위치
    - private subnet에 위치한 인스턴스로 향하는 문지기 역할
3. IAM 
    - ECS 아래 EC2가 수행할 역할 정의
    - 어플리케이션 실행을 위해 처리해야 자원에 접근 하도록 허가
4. Application Load Balancer : load balancer, target group
    - 요청을 ECS로 전송
5. Auto Scaling : auto scaling target, scaling policy(memory, cpu)
    - 요청을 정책을 참고하여 인스턴스 사이에 트래픽 분배
6. ECS : cluster, service, target-definition
    - instance타입을 ec2로 하여 서비스 생성 후 task 생성
    - ec2에 ruby on rails로 작성한 웹 어플리케이션 배포
7. ECR 
    - dockerfile을 저장할 용도, 레포지터리 생성

