mysql -X -e "select c.user_id as uid,concat('FIP:',p.name) as repository,case when u.name is null then c.login else u.name end as name,c.cert as cert from ssg.client_cert as c left join ssg.identity_provider as p on c.provider = p.goid left join ssg.fed_user as u on unhex(c.user_id) = u.goid union select hex(goid) as uid,'Trusted Certificate' as repository,name,cert_base64 as cert from ssg.trusted_cert;" > check.xml
curl -X POST -d @check.xml -H "Content-Type: application/xml; charset=utf-8" http://localhost:8080/parse_certs?days=30
rm -f check.xml
