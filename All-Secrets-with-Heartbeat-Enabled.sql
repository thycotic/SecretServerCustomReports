/* All Secrets with Heartbeat enabled */

SELECT * FROM tbSecret s
JOIN tbSecretType st ON s.SecretTypeID = st.SecretTypeID
WHERE s.LastHeartBeatStatus != 3
AND st.EnableHeartBeat != 0