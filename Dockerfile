FROM flyway/flyway:latest

COPY conf/flyway.conf /flyway/conf/

COPY sql /flyway/sql

CMD ["migrate"]
