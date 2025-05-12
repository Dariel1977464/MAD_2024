CREATE FUNCTION dbo.MyFunction()
RETURNS int
AS
BEGIN
    -- Declare a variable
    DECLARE @MyValue VARCHAR(50) = 'Hello';
	declare @intee int;

	--set @intee = 1

    select @intee = SueldoBase_Diario from Departamento where ID_Departamento = 1

    -- Return the result table
    RETURN @intee;
END;
------------------------------------------------------------------------------------------------------------------
drop function dbo.MyFunction
select dbo.F_SUELDO_NETO(5)
select dbo.MyFunction()




