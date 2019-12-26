

Create procedure numberTest
(@Test varchar(10))
as 
BEGIN
	DECLARE @lenNum int, @startNum int = 1;

	SET @lenNum = LEN(@Test)

	declare @TempNum table(val char);

	while(@lenNum > 0)
	BEGIN
		insert into @TempNum
		select LEFT(substring(@Test,@startNum,@lenNum),1)

		SET @lenNum = @lenNum - 1;
		SET @startNum = @startNum + 1;
	END

	--select * from @TempNum

	select val, count(*) as count 
		into #ResultTmp
		from @TempNum 
		group by val

	select replace(
		stuff((
			select ' ' + (cast(val as varchar(20)) + cast(count as varchar(20)) )
		from #ResultTmp
		for xml path('')
		),1,1,'') ,' ','')as Results 
END



