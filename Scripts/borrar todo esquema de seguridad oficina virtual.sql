SELECT * FROM security.Rols
WHERE Name LIKE '%VIRTUAL%'

SELECT * 
FROM security.RolePermissions
WHERE RoleId IN (SELECT RoleId FROM security.Rols
	WHERE Name LIKE '%VIRTUAL%')

SELECT * 
FROM security.Users
WHERE RoleId IN (SELECT RoleId FROM security.Rols
	WHERE Name LIKE '%VIRTUAL%')

SELECT *
FROM security.UserOffices
WHERE UserId IN(
	SELECT UserId 
	FROM security.Users
	WHERE RoleId IN (SELECT RoleId FROM security.Rols
		WHERE Name LIKE '%VIRTUAL%')
)

SELECT * 
FROM security.UserDatas
WHERE UserId IN(
	SELECT UserId 
	FROM security.Users
	WHERE RoleId IN (SELECT RoleId FROM security.Rols
		WHERE Name LIKE '%VIRTUAL%')
)

SELECT *
FROM security.Menus
WHERE MenuId LIKE '%certificates%'

SELECT *
FROM security.RolePermissions
WHERE MenuId LIKE '%certificates%'


/*

DELETE
FROM security.UserOffices
WHERE UserId IN(
	SELECT UserId 
	FROM security.Users
	WHERE RoleId IN (SELECT RoleId FROM security.Rols
		WHERE Name LIKE '%VIRTUAL%')
)

DELETE 
FROM security.UserDatas
WHERE UserId IN(
	SELECT UserId 
	FROM security.Users
	WHERE RoleId IN (SELECT RoleId FROM security.Rols
		WHERE Name LIKE '%VIRTUAL%')
)


DELETE 
FROM security.Users
WHERE RoleId IN (SELECT RoleId FROM security.Rols
	WHERE Name LIKE '%VIRTUAL%')


DELETE
FROM security.RolePermissions
WHERE RoleId IN (SELECT RoleId FROM security.Rols
	WHERE Name LIKE '%VIRTUAL%')

DELETE FROM security.Rols
WHERE Name LIKE '%VIRTUAL%'

DELETE 
FROM security.RolePermissions
WHERE MenuId LIKE '%certificates%'


DELETE
FROM security.Menus
WHERE MenuId LIKE '%certificates%'

*/