DSN=host=localhost port=5432 user=postgres password=password dbname=concurrency sslmode=disable timezone=UTC connect_timeout=5
BINARY_NAME=myapp.exe
REDIS="127.0.0.1:6379"
PORT=8080

## build: builds all binaries
build:
	@go build -o ${BINARY_NAME} ./cmd/web
	@echo back end built!

run: build
	@echo Starting...
	@DSN="${DSN}" REDIS="${REDIS}" ./myapp.exe &
	@echo back end started!

clean:
	@echo Cleaning...
	@rm -f ${BINARY_NAME}
	@go clean
	@echo Cleaned!

start: run

stop:
	@echo "Stopping..."
	@pkill -f ${BINARY_NAME}
	@echo Stopped back end

restart: stop start

test:
	@echo "Testing..."
	go test -v ./...