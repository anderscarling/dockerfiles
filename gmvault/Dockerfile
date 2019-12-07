FROM python:2-slim

VOLUME /gmvault/data
VOLUME /gmvault/config

ARG GMVAULT_VERSION=1.9.1
RUN pip install --no-cache-dir gmvault==$GMVAULT_VERSION

# Patch imaplib to allow for huge amounts of emails
RUN sed -i'' -e 's/_MAXLINE = 1000000/_MAXLINE = 50 * 10**6/' /usr/local/lib/python2.7/imaplib.py

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["quick", "user@example.org"]
