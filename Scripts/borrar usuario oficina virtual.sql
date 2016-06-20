DECLARE @Login VARCHAR(100)
SET @Login = '80015310'

DELETE FROM security.UserDatas
WHERE UserId IN(select UserId from security.Users where Login = @Login)

DELETE FROM security.UserOffices
WHERE UserId IN(select UserId from security.Users where Login = @Login)

DELETE FROM security.Users
WHERE [login] =@Login

