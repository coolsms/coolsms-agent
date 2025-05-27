# Coolsms Agent

## 🛑 주의사항 🛑
* 더 이상 쿨에스엠에스 DB 연동형 에이전트는 유지보수 되지 않습니다.
* 문서를 통해 [API 개발연동](https://developers.solapi.com/references/messages/sendManyDetail)을 진행해주시거나, [SOLAPI Github](https://github.com/solapi) 내 SDK를 통해 개발연동을 진행해주시기 바랍니다.

## DB 준비
아래 내용으로 DB 및 계정을 만들어 주세요.
```
CREATE DATABASE msg;
CREATE USER 'msg'@'localhost' IDENTIFIED BY 'msg';
GRANT ALL PRIVILEGES ON msg.* TO 'msg'@'localhost';
```
아래 스키마로 테이블을 만들어 주세요.
```
CREATE TABLE msg (
  id integer  AUTO_INCREMENT primary key,
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
  updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
  sendAttempts SMALLINT DEFAULT 0,
  reportAttempts SMALLINT DEFAULT 0,
  `to` VARCHAR(20) AS (payload->>'$.to') STORED,
  `from` VARCHAR(20) AS (payload->>'$.from') STORED,
  groupId VARCHAR(255) AS (result->>'$.groupId') STORED,
  messageId VARCHAR(255) AS (result->>'$.messageId') STORED,
  statusCode VARCHAR(255) AS (result->>'$.statusCode') STORED,
  statusMessage VARCHAR(255) AS (result->>'$.statusMessage') STORED,
  payload JSON,
  result JSON default NULL,
  sent BOOLEAN default false,
  KEY (`createdAt`),
  KEY (`updatedAt`),
  KEY (`sendAttempts`),
  KEY (`reportAttempts`),
  KEY (`to`),
  KEY (`from`),
  KEY (groupId),
  KEY (messageId),
  KEY (statusCode),
  KEY (sent)
) DEFAULT CHARSET=utf8mb4;
```

## 서비스 데몬 설치

/opt/agent 디렉토리를 만들고 아래로 에이전트 실행파일을 복사합니다.
```
mkdir -p /opt/agent
cp ./agent /opt/agent/agent
```

/opt/agent/db.json 파일을 만들고 DB접속 정보를 입력합니다.
```
vi /opt/agent/db.json
```
db.json 예시
```
{
  "provider": "mysql",
  "dbname": "msg",
  "table": "msg",
  "user": "root",
  "password": "root-password",
  "host": "localhost",
  "port": 3306
}
```

/opt/agent/config.json 파일을 만들고 API Key정보를 입력합니다.
```
vi /opt/agent/config.json
```
config.json 예시
```
{
  "APIKey": "NCSPX2S1CWNQ3D1R",
  "APISecret": "IXHBDCUIKZKUEDPL3KQFQNOIJ15ZHKVL",
  "Protocol": "https",
  "Domain": "api.coolsms.co.kr",
  "Prefix": "",
  "AppId": ""
}
```

## 서비스 데몬 실행
서비스 데몬을 시스템에 등록 및 실행합니다.
```
./agent install
./agent start
```

기본 설치 경로(/opt/agent)와 다르게 설치한 경우 아래와 같이 AGENT_HOME 환경변수를 설정해 주세요
```
export AGENT_HOME=/home/ubuntu/agent
```

## 서비스 데몬 명령
시스템에 등록
```
./agent install
```

데몬 실행
```
./agent start
```

데몬 상태
```
./agent status
```

데몬 정지
```
./agent stop
```

시스템에서 제거
```
./agent remove
```

## 소스 코드 빌드 방법
아래 명령으로 빌드하면 agent 실행파일이 생성됩니다.
```
go build agent.go
```
