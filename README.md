Terraform Project

구성도
-----
![스크린샷 2024-04-18 151025](https://github.com/Yonnghohoy/Terraform/assets/88643834/c0040231-54e4-4a99-b0b9-b424d8ac9b87)

설명
-----
1. Client가 hollyjunho.store 도메인으로 접근
2. CloudFront WAF에서 규칙인 "지역접근허용"을 사용하여 한국, 미국 국가에서만 접근이 가능하며, IP Rule을 통한 IP Allow, Drop.
3. ALB_WAF(Seoul)에서 요청 패킷 Header에 "hollyjunho" 값이 존재하는지 체크하여 있을 경우에만 통과
4. ALB에서 80포트로 요청오는 모든 통신을 443포트로 리다이렉트 및 ACM을 이용한 SSL 적용.
5. RoundRobin 방식으로 이중화된 다른 가용영역의 web 서버안의 nginx 페이지를 출력함.
6. A 가용 영역의 서버는 KMS, Secret Manager로 키가 관리되는 Aurora DB와 연결되어 DB통신 및 Aurora는 다른영역에 복제진행
