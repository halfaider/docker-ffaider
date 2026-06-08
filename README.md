# ffaider Docker Image

GD-Poller 및 Flaskfarmaider-bot을 구동하기 위한 멀티 아키텍처 Docker 이미지입니다.

## 지원 아키텍처
* `linux/amd64`
* `linux/arm64`

## 실행 방법 (Docker Compose)

`docker-compose.yml` 파일에 다음과 같이 서비스를 정의하여 실행할 수 있습니다.

```yaml
services:
  ffaider:
    container_name: ffaider
    image: ghcr.io/halfaider/docker-ffaider:latest
    environment:
      GD_POLLER: "yes"
      GD_POLLER_CONFIG: "/config/gd-poller.yaml"
      # FFAIDER_BOT: "yes"
      # FFAIDER_BOT_CONFIG: "/config/ffaider-bot.yaml"
    volumes:
      - ./data/ffaider/config:/config
```

## 환경 변수 설정

| 환경 변수 | 기본값 | 설명 |
| :--- | :--- | :--- |
| `GD_POLLER` | `no` | GD Poller 활성화 여부 (`yes` / `no`) |
| `GD_POLLER_CONFIG` | `/config/gd-poller.yaml` | Poller 설정 파일 경로 |
| `FFAIDER_BOT` | `no` | FFAIDER Bot 활성화 여부 (`yes` / `no`) <br>*(⚠️ GDS 방송용 스크립트로, 일반 구동 시 비활성화를 권장합니다.)* |
| `FFAIDER_BOT_CONFIG` | `/config/ffaider-bot.yaml` | Bot 설정 파일 경로 |

> [!IMPORTANT]
> `GD_POLLER`와 `FFAIDER_BOT` 중 **최소 하나 이상은 반드시 `"yes"`로 설정**해야 컨테이너가 정상적으로 실행됩니다. (둘 다 비어있거나 `no`일 경우 에러와 함께 즉시 종료됩니다.)

## 볼륨 마운트

* `/config`: 설정 파일들이 저장되어 있는 컨테이너 내부 경로입니다. 호스트 디렉토리와 연동하여 관리합니다.
