-- DAY 12 ASSIGNMENT

/*
   Create a user-defined function that takes two input parameters of DATE data type.
   The function should return the number of business days between the two dates.
   Note: If any of the two input dates fall on a Saturday or Sunday, the function should use the immediate Monday date for calculation.
   
   Example: If we pass dates as '2022-12-18' and '2022-12-24', it should calculate business days between '2022-12-19' and '2022-12-26'.
*/

CREATE FUNCTION getBusinessDays
(
    @StartDate DATE, 
    @EndDate DATE
)
RETURNS INT
AS 
BEGIN 
    DECLARE @BusinessDays INT = 0;
    DECLARE @CurrentDate DATE = @StartDate;

    WHILE @CurrentDate <= @EndDate
    BEGIN
        IF DATEPART(WEEKDAY, @CurrentDate) NOT IN (1, 7)
        BEGIN
            SET @BusinessDays = @BusinessDays + 1;
        END

        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
    END

    RETURN @BusinessDays;
END;

-- Example usage:
SELECT dbo.getBusinessDays('2023-11-01', '2023-11-10');
