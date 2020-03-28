# jpmens/mosquitto-auth-plug sample configuration
auth_plugin /usr/lib/auth-plug.so
auth_opt_backends redis
#auth_opt_backends redis,http
auth_opt_superusers admin
auth_opt_redis_userquery GET %s
auth_opt_redis_aclquery GET %s-%s
auth_opt_redis_host redis-mosq
auth_opt_redis_port 6379

#auth_opt_http_ip 127.0.0.1
#auth_opt_http_getuser_uri /auth
#auth_opt_http_superuser_uri /superuser
#auth_opt_http_aclcheck_uri /acl
#auth_opt_http_getuser_params domain=DOMAIN,port=PORT
#auth_opt_http_superuser_params domain=DOMAIN,port=PORT
#auth_opt_http_aclcheck_params domain=DOMAIN,port=PORT

# Usernames with this fnmatch(3) (a.k.a glob(3))  pattern are exempt from the
# module's ACL checking
auth_opt_superusers adm*
