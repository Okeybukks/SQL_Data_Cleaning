WITH tableone as (SELECT jobtitle, DATE_TRUNC('month', timestamp ) as Month, DATE_Part('year', timestamp ) as Year,
      CASE 
      WHEN postcollegework LIKE '%-%'
      THEN REGEXP_REPLACE(SPLIT_PART(postcollegework,'-',2),'[^0-9]*','','g')::FLOAT
      
      WHEN postcollegework LIKE '%or%'
      THEN REGEXP_REPLACE(SPLIT_PART(postcollegework,' ',1),'[^0-9]*','','g')::FLOAT
      
      END AS "Experience",
      
      CASE
      WHEN currency = 'USD'
      AND LOWER(annualsalary) NOT LIKE '%k'
      AND (LOWER(annualsalary) NOT LIKE '$%' OR LOWER(annualsalary) NOT LIKE '%$%' OR LOWER(annualsalary) NOT LIKE '%$')
      AND LOWER(annualsalary) NOT LIKE '%.%'
      AND LOWER(annualsalary) NOT LIKE '%yr'
      AND LOWER(annualsalary) NOT LIKE '%hr%'
      AND LOWER(annualsalary) NOT LIKE '%-%'
      AND (LOWER(annualsalary) NOT LIKE '%match' OR LOWER(annualsalary) NOT LIKE '%($%')
      AND LOWER(annualsalary) NOT LIKE '%bonus%'
      AND LOWER(annualsalary) NOT LIKE '%bonus'
      AND LOWER(annualsalary) NOT LIKE '%bonuses'
      AND LOWER(annualsalary) NOT LIKE '%bonuses%'
      AND LOWER(annualsalary) NOT LIKE '%per%'
      AND LOWER(annualsalary) NOT LIKE '%hour'
      AND LOWER(annualsalary) NOT LIKE '%equity'
      AND LOWER(annualsalary) NOT LIKE '%includes $%'
      AND LOWER(annualsalary) NOT LIKE '%(base%'
      AND LOWER(annualsalary) NOT LIKE '% ($%'
      AND LOWER(annualsalary) NOT LIKE '%diffentials'
      AND LOWER(annualsalary) NOT LIKE '%worked'
      AND LOWER(annualsalary) NOT LIKE '%of approx%'
      AND LOWER(annualsalary) NOT LIKE '%k plus commission'
      AND LOWER(annualsalary) NOT LIKE '%benefite'
      AND annualsalary NOT LIKE '%OTH%'
      AND LOWER(annualsalary) NOT LIKE '%k%'
      AND LENGTH(annualsalary) != 3  
      AND LENGTH(annualsalary) != 2
      AND LENGTH(annualsalary) != 1
      AND LOWER(annualsalary) NOT LIKE '1 million'
      AND LOWER(annualsalary) NOT LIKE '%,oo%'
      AND LOWER(annualsalary) NOT LIKE '$85 thousand'
      AND LOWER(annualsalary) NOT LIKE '%salary; $%'
      AND LOWER(annualsalary) NOT LIKE 'varies from%'
      AND LOWER(annualsalary) NOT LIKE '%possible)'
      AND LOWER(annualsalary) NOT LIKE '%total)'
      AND LOWER(annualsalary) NOT LIKE '%went from%'
      AND LOWER(annualsalary) NOT LIKE '%in overtime'
      AND LOWER(annualsalary) NOT LIKE '%base 41%'
      AND LOWER(annualsalary) NOT LIKE '%000 / 00%'
      AND LOWER(annualsalary) NOT LIKE '%on ot'
      AND LOWER(annualsalary) NOT LIKE '%0–50,%'
      AND LOWER(annualsalary) NOT LIKE '%\%%'
      AND LOWER(annualsalary) NOT LIKE '%year to year)'
      AND LOWER(annualsalary) NOT LIKE '%2018)'
      AND LOWER(annualsalary) NOT LIKE '%sti'
      AND LOWER(annualsalary) NOT LIKE '%of base)'
      AND LOWER(annualsalary) NOT LIKE '%hourly or%'
      AND LOWER(annualsalary) NOT LIKE '% / %'
      AND LOWER(annualsalary) NOT LIKE '%00-00%'
      AND LOWER(annualsalary) NOT LIKE '~27,600%'
      THEN NULLIF(REGEXP_REPLACE(annualsalary,'[^0-9]*','','g'),'')::FLOAT
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%.00%'
      AND LOWER(annualsalary) NOT LIKE '%k'
      AND LOWER(annualsalary) NOT LIKE '%hr'
      AND LOWER(annualsalary) NOT LIKE '%hour'
      AND LOWER(annualsalary) NOT LIKE '%hourly'
      AND LOWER(annualsalary) NOT LIKE '%.500.%'
      AND annualsalary NOT LIKE '%USD'
      AND LENGTH(LOWER(annualsalary)) >7
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',1),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%.00%'
      AND LOWER(annualsalary) NOT LIKE '%k'
      AND (LOWER(annualsalary) LIKE '%hr' OR LOWER(annualsalary) LIKE '%hour' OR LENGTH(LOWER(annualsalary)) < 7
      OR LOWER(annualsalary) LIKE '%hourly')
      AND LOWER(annualsalary) NOT LIKE '%bonus%'
      AND LOWER(annualsalary) NOT LIKE '%bonus'
      AND LOWER(annualsalary) NOT LIKE '%bonuses'
      AND LOWER(annualsalary) NOT LIKE '%bonuses%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',1),'[^0-9]*','','g')::FLOAT * 40 * 52
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%.00%'
      AND LOWER(annualsalary) NOT LIKE '%bonus%'
      AND LOWER(annualsalary) NOT LIKE '%bonus'
      AND LOWER(annualsalary) NOT LIKE '%bonuses'
      AND LOWER(annualsalary) NOT LIKE '%bonuses%'
      AND LENGTH(LOWER(annualsalary)) = 7
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',1),'[^0-9]*','','g')::FLOAT*1000
      
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%k' OR annualsalary LIKE '%K base' 
            OR annualsalary LIKE '%K+' OR annualsalary LIKE '%calendar'
            OR annualsalary LIKE '%boss%')
      AND LOWER(annualsalary) NOT LIKE '%-%'
      AND LOWER(annualsalary) NOT LIKE '%.%'
      AND LOWER(annualsalary) NOT LIKE '%to%'
      AND LOWER(annualsalary) NOT LIKE '%week'
      AND LOWER(annualsalary) NOT LIKE '%hour%'
      AND LOWER(annualsalary) NOT LIKE '%work'
      AND LOWER(annualsalary) NOT LIKE '%=%'
      AND LOWER(annualsalary) NOT LIKE '11/hour%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT*1000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%k'
      AND LOWER(annualsalary) LIKE '%-%'
      AND LOWER(annualsalary) NOT LIKE '%bonus%'
      AND LOWER(annualsalary) NOT LIKE '%bonus'
      AND LOWER(annualsalary) NOT LIKE '%bonuses'
      AND LOWER(annualsalary) NOT LIKE '%bonuses%'     
      AND LOWER(annualsalary) NOT LIKE '%a%'
      THEN(REGEXP_REPLACE(SPLIT_PART(annualsalary,'-',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(annualsalary,'-',2),'[^0-9]*','','g')::FLOAT)*500
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%k'
      AND LOWER(annualsalary) LIKE '%to%'
      AND LOWER(annualsalary) NOT LIKE '%bonus%'
      AND LOWER(annualsalary) NOT LIKE '%bonus'
      AND LOWER(annualsalary) NOT LIKE '%bonuses'
      AND LOWER(annualsalary) NOT LIKE '%bonuses%'     
      AND LOWER(annualsalary) NOT LIKE '%per%'
      AND LOWER(annualsalary) NOT LIKE '%stock'
      THEN (REGEXP_REPLACE(SPLIT_PART(annualsalary,'to',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(annualsalary,'to',2),'[^0-9]*','','g')::FLOAT)*500
          
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%stock'
      AND LOWER(annualsalary) LIKE '%+%'
      AND LOWER(annualsalary) NOT LIKE '%bonus%'
      AND LOWER(annualsalary) NOT LIKE '%bonus'
      AND LOWER(annualsalary) NOT LIKE '%bonuses'
      AND LOWER(annualsalary) NOT LIKE '%bonuses%'     
      AND LOWER(annualsalary) NOT LIKE '%per%'
      THEN (REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',2),'[^0-9]*','','g')::FLOAT)/2
          
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%to%'
      AND LOWER(annualsalary) LIKE '%per%'
      AND LOWER(annualsalary) NOT LIKE '%bonus%'
      AND LOWER(annualsalary) NOT LIKE '%bonus'
      AND LOWER(annualsalary) NOT LIKE '%bonuses'
      AND LOWER(annualsalary) NOT LIKE '%bonuses%'     
      THEN 11.5 * 30 * 52
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%k'
      AND LOWER(annualsalary) NOT LIKE '%bonus%'
      AND LOWER(annualsalary) NOT LIKE '%bonus'
      AND LOWER(annualsalary) NOT LIKE '%bonuses'
      AND LOWER(annualsalary) NOT LIKE '%bonuses%'     
      AND LOWER(annualsalary) LIKE '%-%'
      AND LOWER(annualsalary) LIKE '%no%'
      THEN 45000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%week'
      AND LOWER(annualsalary) LIKE '%k'
      AND LOWER(annualsalary) NOT LIKE '%bonus%'
      AND LOWER(annualsalary) NOT LIKE '%bonus'
      AND LOWER(annualsalary) NOT LIKE '%bonuses'
      AND LOWER(annualsalary) NOT LIKE '%bonuses%' 
      AND (LOWER(annualsalary) LIKE '%/week' OR LOWER(annualsalary) LIKE '%per%' OR LOWER(annualsalary) LIKE '%over%' )
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%week'
      AND LOWER(annualsalary) LIKE '%k'
      AND LOWER(annualsalary) LIKE '%/hr%'
      AND LOWER(annualsalary) NOT LIKE '%bonus%'
      AND LOWER(annualsalary) NOT LIKE '%bonus'
      AND LOWER(annualsalary) NOT LIKE '%bonuses'
      AND LOWER(annualsalary) NOT LIKE '%bonuses%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT * 25 * 52
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%week'
      AND LOWER(annualsalary) LIKE '%k'
      AND LOWER(annualsalary) LIKE '@%'
      THEN 80000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%week'
      AND LOWER(annualsalary) LIKE '%k'
      AND LOWER(annualsalary) LIKE '%for%'
      AND LOWER(annualsalary) NOT LIKE '%bonus%'
      AND LOWER(annualsalary) NOT LIKE '%bonus'
      AND LOWER(annualsalary) NOT LIKE '%bonuses'
      AND LOWER(annualsalary) NOT LIKE '%bonuses%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT * 20 * 52 
      
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%k'
      AND LOWER(annualsalary) NOT LIKE '%bonus%'
      AND LOWER(annualsalary) NOT LIKE '%bonus'
      AND LOWER(annualsalary) NOT LIKE '%bonuses'
      AND LOWER(annualsalary) NOT LIKE '%bonuses%'     
      AND annualsalary LIKE '%approx%'
      THEN 68000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%hr%'
      AND LOWER(annualsalary) NOT LIKE '%bonus%'
      AND LOWER(annualsalary) NOT LIKE '%bonus'
      AND LOWER(annualsalary) NOT LIKE '%bonuses'
      AND LOWER(annualsalary) NOT LIKE '%bonuses%'     
      AND LOWER(annualsalary) NOT LIKE '%or %'
      AND LOWER(annualsalary) NOT LIKE '%pretax%'
      AND LOWER(annualsalary) NOT LIKE '%min%'
      AND LOWER(annualsalary) NOT LIKE '%appx%'
      AND LOWER(annualsalary) NOT LIKE '%.%'
      AND LOWER(annualsalary) NOT LIKE '%to %'
      AND LOWER(annualsalary) NOT LIKE '%wk)'
      AND LOWER(annualsalary) NOT LIKE '%appr%'
      AND annualsalary NOT LIKE 'Not%'
      AND LOWER(annualsalary) NOT LIKE '%at%'
      AND LOWER(annualsalary) NOT LIKE '%*%'
      AND LOWER(annualsalary) NOT LIKE '%part%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT * 5 * 8 * 52     
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%hr%'
      AND LOWER(annualsalary) LIKE '%or %'
      AND LOWER(annualsalary) NOT LIKE '%in%'
      AND LOWER(annualsalary) NOT LIKE '%k/%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'or',2),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%hr%'
      AND LOWER(annualsalary) LIKE '%or %'
      AND LOWER(annualsalary) LIKE '%k/%'
      AND LOWER(annualsalary) NOT LIKE '%in%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'or',2),'[^0-9]*','','g')::FLOAT*1000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%hr%'
      AND LOWER(annualsalary) LIKE '%for%'
      AND LOWER(annualsalary) LIKE '%in%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'for',1),'[^0-9]*','','g')::FLOAT * 5 * 8 * 52   
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%hr%'
      AND LOWER(annualsalary) NOT LIKE '%type%'
      AND LOWER(annualsalary) NOT LIKE '%min%'
      AND LOWER(annualsalary) LIKE '%.%'
      AND LOWER(annualsalary) NOT LIKE '%wk%)'
      AND LOWER(annualsalary) NOT LIKE '%+%'
      THEN (REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,' ',1),'.',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,' ',1),'.',2),'[^0-9]*','','g')::FLOAT/100)* 5 * 8 * 52
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%hr%'
      AND (LOWER(annualsalary) LIKE '%at%' OR LOWER(annualsalary) LIKE '%*%')
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT * 1000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%hr%'
      AND LOWER(annualsalary) LIKE '%part%'
      AND LOWER(annualsalary) LIKE '%hr,%'
      AND LOWER(annualsalary) NOT LIKE '%bonus%'
      AND LOWER(annualsalary) NOT LIKE '%bonus'
      AND LOWER(annualsalary) NOT LIKE '%bonuses'
      AND LOWER(annualsalary) NOT LIKE '%bonuses%' 
      THEN 27.5 * 40 * 52
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%hr%'
      AND LOWER(annualsalary) LIKE '%part%'
      AND LOWER(annualsalary) LIKE '%week%'
      AND LOWER(annualsalary) NOT LIKE '%bonus%'
      AND LOWER(annualsalary) NOT LIKE '%bonus'
      AND LOWER(annualsalary) NOT LIKE '%bonuses'
      AND LOWER(annualsalary) NOT LIKE '%bonuses%'
      THEN 24000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%hr%'
      AND LOWER(annualsalary) NOT LIKE '%bonus%'
      AND LOWER(annualsalary) NOT LIKE '%bonus'
      AND LOWER(annualsalary) NOT LIKE '%bonuses'
      AND LOWER(annualsalary) NOT LIKE '%bonuses%' 
      AND annualsalary LIKE 'Not%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,',',2),'[^0-9]*','','g')::FLOAT * 40 * 52
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%hr%'
      AND LOWER(annualsalary) LIKE '%to%'
      THEN 39 * 40 * 52
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%hr%'
      AND LOWER(annualsalary)  LIKE '%min%'
      THEN 15 * 40 * 52
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%hr%'
      AND (LOWER(annualsalary) LIKE '%shift%' OR LOWER(annualsalary) LIKE '%diem%')
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT * 5 * 8 * 52   
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%hr%'
      AND LOWER(annualsalary) LIKE '%wk)'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%equity' OR LOWER(annualsalary) LIKE '%+ bonus' 
          OR LOWER(annualsalary) LIKE '%plus bonus' OR LOWER(annualsalary) LIKE '%plus bonuses'
          OR LOWER(annualsalary) LIKE '%k + bonus%')
      AND LOWER(annualsalary) LIKE '%k%'
      AND LOWER(annualsalary) NOT LIKE '%\%%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT * 1000

      WHEN currency = 'USD' 
      AND annualsalary LIKE '%includes $%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '$%'
      AND LOWER(annualsalary) LIKE '%-%'
      AND annualsalary LIKE '%K%'
      THEN (REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'+',1),'-',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'+',1),'-',2),'[^0-9]*','','g')::FLOAT) * 500
      
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary)  LIKE '$%'
      AND LOWER(annualsalary)  LIKE '%.%'
      AND LOWER(annualsalary) NOT LIKE '%bonus'
      AND LOWER(annualsalary)  NOT LIKE '%.00%'
      AND LOWER(annualsalary) NOT LIKE '%hr%'
      AND LOWER(annualsalary) NOT LIKE '%hour%'
      AND LOWER(annualsalary) NOT LIKE '%an%'
      AND LOWER(annualsalary) NOT LIKE '%th%'
      AND LOWER(annualsalary) NOT LIKE '%m'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',2),'[^0-9]*','','g')::FLOAT/100
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary)  LIKE '$%'
      AND (LOWER(annualsalary)  LIKE '%.%' OR LOWER(annualsalary)  LIKE '% ($%')
      AND (LOWER(annualsalary) LIKE '%th%' OR LOWER(annualsalary)  LIKE '%inc.%' 
          OR LOWER(annualsalary)  LIKE '% ($%' OR LOWER(annualsalary)  LIKE '%am%')
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary)  LIKE '$%'
      AND LOWER(annualsalary)  LIKE '%.%'
      AND LOWER(annualsalary)  LIKE '%hour%'
      AND LOWER(annualsalary) NOT LIKE '%am%'
      THEN (REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,' ',1),'.',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,' ',1),'.',2),'[^0-9]*','','g')::FLOAT/100) * 40 * 52
      
      WHEN currency = 'USD' 
      AND LOWER(annualsalary)  LIKE '$%'
      AND LOWER(annualsalary)  LIKE '%.%'
      AND LOWER(annualsalary)  LIKE '%m'
      AND LOWER(annualsalary) NOT LIKE '%equity%'
      THEN 1400000
      
      WHEN currency = 'USD' 
      AND LOWER(annualsalary)  LIKE '$%'
      AND LOWER(annualsalary)  LIKE '%.%'
      AND LOWER(annualsalary)  LIKE '%m'
      AND LOWER(annualsalary)  LIKE '%equity%'
      THEN 480000
      
      WHEN currency = 'USD' 
      AND LOWER(annualsalary)  LIKE '$%'
      AND LOWER(annualsalary)  LIKE '%.%'
      AND LOWER(annualsalary)  LIKE '%\%%'
      THEN 48000
      
      WHEN currency = 'USD' 
      AND LOWER(annualsalary)  LIKE '$%'
      AND LOWER(annualsalary)  LIKE '%base,%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'base,',2),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '$%'
      AND (LOWER(annualsalary) LIKE '%hour' OR LOWER(annualsalary) LIKE '%during%')
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT * 40 * 52
      
      WHEN currency = 'USD' 
      AND LOWER(annualsalary) LIKE '$%'
      AND LOWER(annualsalary) LIKE '%-%'
      AND (annualsalary LIKE '%the%' OR annualsalary LIKE '%W2%')
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT 
    
      WHEN currency = 'USD' 
      AND LOWER(annualsalary) LIKE '$%'
      AND LOWER(annualsalary) LIKE '%-%'
      AND LOWER(annualsalary) LIKE '%80%'
      THEN (REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,' ',1),'-',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,' ',1),'-',2),'[^0-9]*','','g')::FLOAT)/2
       
      WHEN currency = 'USD'     
      AND LOWER(annualsalary) LIKE '$%'
      AND LOWER(annualsalary) LIKE '%yr'
      AND LOWER(annualsalary) LIKE '%k%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 1000
      
      WHEN currency = 'USD'     
      AND LOWER(annualsalary) LIKE '$%'
      AND LOWER(annualsalary) LIKE '%yr' 
      AND LOWER(annualsalary) NOT LIKE '%k%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'     
      AND LOWER(annualsalary) LIKE '$%'
      AND LOWER(annualsalary) LIKE '%diffentials'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 40 * 52
      
      WHEN currency = 'USD'     
      AND LOWER(annualsalary) LIKE '$%'
      AND LOWER(annualsalary) LIKE '%worked'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'/',1),'[^0-9]*','','g')::FLOAT * 40 * 52
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '$%'
      AND LOWER(annualsalary) LIKE '%of approx%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'of',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(annualsalary,'of',2),'[^0-9]*','','g')::FLOAT 
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '$%'    
      AND (LOWER(annualsalary) LIKE '%k plus commission' OR LOWER(annualsalary) LIKE '%benefite')
      THEN 100000
      
      WHEN currency = 'USD'
      AND annualsalary LIKE '%OTH%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'STH',2),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND annualsalary LIKE '%take'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%+ bonus ' OR LOWER(annualsalary) LIKE '%+bonus' 
          OR LOWER(annualsalary) LIKE '%+ bonus' OR LOWER(annualsalary) LIKE '%plus bonus' 
          OR LOWER(annualsalary) LIKE '%plus bonus%' OR LOWER(annualsalary) LIKE '%bonuses' 
          OR LOWER(annualsalary) LIKE '%+ bonus%' OR LOWER(annualsalary) LIKE '%+ bonus%'
          OR LOWER(annualsalary) LIKE '%including bo%' OR LOWER(annualsalary) LIKE '%plus annual%'
          OR LOWER(annualsalary) LIKE '%plus annual%' OR LOWER(annualsalary) LIKE '%+ annual%'
          OR LOWER(annualsalary) LIKE '%+bonus%' OR LOWER(annualsalary) LIKE '%quarterly bonus '
          OR LOWER(annualsalary) LIKE '%bonus)' OR LOWER(annualsalary) LIKE '%after bonus '
          OR LOWER(annualsalary) LIKE '%, bonuses%' OR (annualsalary) LIKE '%OT%'
          OR LOWER(annualsalary) LIKE '%base salary%')
      AND LOWER(annualsalary) NOT LIKE '%allowances)'
      AND LOWER(annualsalary) NOT LIKE '%about $%'
      AND LOWER(annualsalary) NOT LIKE '%yr'
      AND LOWER(annualsalary) NOT LIKE '%max%'
      AND LOWER(annualsalary) NOT LIKE '%m'
      AND LOWER(annualsalary) NOT LIKE '%-$%'
      AND LOWER(annualsalary) NOT LIKE '%match'
      AND LOWER(annualsalary) NOT LIKE '%of%'
      AND LOWER(annualsalary) NOT LIKE '%bring%'
      AND LOWER(annualsalary) NOT LIKE '%\%%'
      AND LOWER(annualsalary) NOT LIKE '%k after%'
      AND LOWER(annualsalary) NOT LIKE '%appx%'
      AND LOWER(annualsalary) NOT LIKE 'base%'
      AND LOWER(annualsalary) NOT LIKE '%.00%'
      AND LOWER(annualsalary) NOT LIKE '%in bonuses'
      AND LOWER(annualsalary) NOT LIKE '%up to%'
      AND annualsalary NOT LIKE '%Commission'
      THEN REGEXP_REPLACE(SPLIT_PART(LOWER(annualsalary),' ',1),'[^0-9]*','','g')::FLOAT
      
      
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%\%%'
      AND LOWER(annualsalary) LIKE '%+%'
      AND LOWER(annualsalary) NOT LIKE '%-%'
      AND LOWER(annualsalary) NOT LIKE '%\% to%'
      AND LOWER(annualsalary) NOT LIKE '%k%'
      THEN (REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',1),'[^0-9]*','','g')::FLOAT *
      (1 + (REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',2),'[^0-9]*','','g')::FLOAT)/100))
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%\%%'
      AND LOWER(annualsalary) LIKE '%-%'
      AND LOWER(annualsalary) NOT LIKE '%on my%'
      THEN (REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',1),'[^0-9]*','','g')::FLOAT *
      (1 + ((REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'+',2),'-',1),'[^0-9]*','','g')::FLOAT)+
            (REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'+',2),'-',2),'[^0-9]*','','g')::FLOAT))/200))
            
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%\%%'
      AND LOWER(annualsalary) LIKE '%-%'
      AND LOWER(annualsalary) LIKE '%on my%'
      THEN (REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,' ',2),'-',1),'[^0-9]*','','g')::FLOAT +
           REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,' ',2),'-',2),'[^0-9]*','','g')::FLOAT)*500
       
       
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%\%%'
      AND LOWER(annualsalary) LIKE '%\% to%'
      THEN (REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',1),'[^0-9]*','','g')::FLOAT *
      (1 + ((REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'+',2),'to',1),'[^0-9]*','','g')::FLOAT)+
            (REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'+',2),'to',2),'[^0-9]*','','g')::FLOAT))/200))
            
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%\%%'
      AND LOWER(annualsalary) LIKE '%plus%'
      AND LOWER(annualsalary) NOT LIKE '%equity'
      AND LOWER(annualsalary) NOT LIKE '%rsu%'
      THEN (REGEXP_REPLACE(SPLIT_PART(LOWER(annualsalary),'plus',1),'[^0-9]*','','g')::FLOAT *
      (1 + (REGEXP_REPLACE(SPLIT_PART(LOWER(annualsalary),'plus',2),'[^0-9]*','','g')::FLOAT)/100))
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%\%%'
      AND LOWER(annualsalary) LIKE '%paid%'
      THEN (REGEXP_REPLACE(SPLIT_PART(LOWER(annualsalary),' ',1),'[^0-9]*','','g')::FLOAT *
      (1 + (REGEXP_REPLACE(SPLIT_PART(LOWER(annualsalary),' ',3),'[^0-9]*','','g')::FLOAT)/100))
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%\%%'
      AND (LOWER(annualsalary) LIKE '%brings%' OR LOWER(annualsalary) LIKE '%equity')
      THEN (REGEXP_REPLACE(SPLIT_PART(LOWER(annualsalary),' ',1),'[^0-9]*','','g')::FLOAT *
      (1 + (REGEXP_REPLACE(SPLIT_PART(LOWER(annualsalary),' ',3),'[^0-9]*','','g')::FLOAT)/100))
            
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%\% bonus%'
      AND LOWER(annualsalary) LIKE '%award'
      THEN (REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',1),'[^0-9]*','','g')::FLOAT *
            (1 + (REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'+',2),' ',1),'[^0-9]*','','g')::FLOAT)/100)) + 40000
            
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%\%%'
      AND LOWER(annualsalary) LIKE '%(%'
      AND LOWER(annualsalary) NOT LIKE '%yr'
      THEN (REGEXP_REPLACE(SPLIT_PART(annualsalary,'(',1),'[^0-9]*','','g')::FLOAT *
      (1 + (REGEXP_REPLACE(SPLIT_PART(annualsalary,'(',2),'[^0-9]*','','g')::FLOAT)/100))
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%\%%'
      AND LOWER(annualsalary) LIKE '%(%'
      AND LOWER(annualsalary) LIKE '%yr'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT
      
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%+ bonus%'  OR LOWER(annualsalary) LIKE '%+about%' 
          OR LOWER(annualsalary) LIKE '%/stock')
      AND LOWER(annualsalary) NOT LIKE '%eligible'
      AND LOWER(annualsalary) NOT LIKE '%equity'
      AND LOWER(annualsalary) NOT LIKE '%)'
      AND LOWER(annualsalary) NOT LIKE '%ks'
      AND LOWER(annualsalary) NOT LIKE '%grants'
      AND LOWER(annualsalary) NOT LIKE '%pays'
      AND LOWER(annualsalary) NOT LIKE '%with%'
      AND LOWER(annualsalary) NOT LIKE '%/hr%'
      AND LOWER(annualsalary) NOT LIKE '%match'
      AND LOWER(annualsalary) NOT LIKE '%target%'
      AND LOWER(annualsalary) NOT LIKE '%bonuses'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',1),'[^0-9]*','','g')::FLOAT +
            REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',2),'[^0-9]*','','g')::FLOAT
           
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%with%'
      AND LOWER(annualsalary) NOT LIKE '%k'
      AND LOWER(annualsalary) NOT LIKE '%(%'
      AND LOWER(annualsalary) NOT LIKE '%opportunity'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'with',1),'[^0-9]*','','g')::FLOAT +
      REGEXP_REPLACE(SPLIT_PART(annualsalary,'with',2),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%with%'
      AND LOWER(annualsalary) LIKE '%k'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'with',1),'[^0-9]*','','g')::FLOAT +
      REGEXP_REPLACE(SPLIT_PART(annualsalary,'with',2),'[^0-9]*','','g')::FLOAT * 1000 
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%base%'
      AND LOWER(annualsalary) LIKE '%k%'
      AND LOWER(annualsalary) NOT LIKE '%\%%'
      AND LOWER(annualsalary) NOT LIKE '%=%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'base',1),'[^0-9]*','','g')::FLOAT +
      REGEXP_REPLACE(SPLIT_PART(annualsalary,'base',2),'[^0-9]*','','g')::FLOAT * 1000
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%base%'
      AND LOWER(annualsalary) LIKE '%k%'
      AND LOWER(annualsalary) LIKE '%\%%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'base',1),'[^0-9]*','','g')::FLOAT*1.44
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%base%'
      AND LOWER(annualsalary) LIKE '%k%'
      AND LOWER(annualsalary) LIKE '%=%'
      THEN (REGEXP_REPLACE(SPLIT_PART(annualsalary,'base',1),'[^0-9]*','','g')::FLOAT +
      REGEXP_REPLACE(SPLIT_PART(annualsalary,'base',2),'[^0-9]*','','g')::FLOAT) * 1000
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%k%'
      AND LOWER(annualsalary) LIKE '%including%'
      AND LOWER(annualsalary) NOT LIKE '%annual%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'including',1),'[^0-9]*','','g')::FLOAT +
      REGEXP_REPLACE(SPLIT_PART(annualsalary,'including',2),'[^0-9]*','','g')::FLOAT * 1000
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%k%'
      AND LOWER(annualsalary) LIKE '%including%'
      AND LOWER(annualsalary) LIKE '%annual%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'including',1),'[^0-9]*','','g')::FLOAT * 1000
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonuses' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%+%'
      AND LOWER(annualsalary) NOT LIKE '%k%'
      AND LOWER(annualsalary) NOT LIKE '%.%'
      AND LOWER(annualsalary) NOT LIKE '%-%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',1),'[^0-9]*','','g')::FLOAT +
      REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',2),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonuses' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%+%'
      AND LOWER(annualsalary) LIKE '%.%'
      AND LOWER(annualsalary) NOT LIKE '%$%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',1),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonuses' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%+%'
      AND LOWER(annualsalary) LIKE '%.%'
      AND LOWER(annualsalary) LIKE '%$%'
      THEN REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'+',1),'.',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'+',1),'.',2),'[^0-9]*','','g')::FLOAT*0.01 +
          REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',2),'[^0-9]*','','g')::FLOAT
           
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonuses' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%about%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'about',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(annualsalary,'about',2),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonuses' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%+%'
      AND LOWER(annualsalary) LIKE '%\%%'
      AND LOWER(annualsalary) LIKE '%k%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',1),'[^0-9]*','','g')::FLOAT * 1000 *
      (1 + (REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',2),'[^0-9]*','','g')::FLOAT/100))
          
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonuses' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%plus%' 
      AND LOWER(annualsalary) NOT LIKE '%k%'
      AND LOWER(annualsalary) NOT LIKE '%.%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'plus',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(annualsalary,'plus',2),'[^0-9]*','','g')::FLOAT
           
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonuses' OR LOWER(annualsalary) LIKE '%bonus' 
          OR LOWER(annualsalary) LIKE '%bonus%' )
      AND LOWER(annualsalary) LIKE '%plus%'
      AND LOWER(annualsalary) NOT LIKE '%k%'
      AND LOWER(annualsalary) NOT LIKE 'base%'
      AND LOWER(annualsalary) LIKE '%.%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',1),'[^0-9]*','','g')::FLOAT 
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonuses' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%-%'
      AND LOWER(annualsalary) LIKE '%depending%'
      THEN (REGEXP_REPLACE(SPLIT_PART(annualsalary,'-',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(annualsalary,'-',2),'[^0-9]*','','g')::FLOAT )/2
           
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonuses' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%-%'
      AND LOWER(annualsalary) LIKE '%plus%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'plus',1),'[^0-9]*','','g')::FLOAT +
          (REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'plus',2),'-',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'plus',2),'-',2),'[^0-9]*','','g')::FLOAT)*500
           
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonuses' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%-%'
      AND LOWER(annualsalary) LIKE '%possible%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',1),'[^0-9]*','','g')::FLOAT +
          ((REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'+',2),'-',1),'[^0-9]*','','g')::FLOAT * 1000) +
          REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'+',2),'-',2),'[^0-9]*','','g')::FLOAT)/2
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonuses' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%to%'
      AND LOWER(annualsalary) LIKE '%k%'
      AND LOWER(annualsalary) NOT LIKE '%up%'
      AND LOWER(annualsalary) NOT LIKE '%and%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',1),'[^0-9]*','','g')::FLOAT +
          (REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'+',2),'to',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'+',2),'to',2),'[^0-9]*','','g')::FLOAT)*500
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonuses' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%to%'
      AND LOWER(annualsalary) LIKE '%k%'
      AND LOWER(annualsalary) LIKE '%up%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT +
          17000
           
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonuses' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%to%'
      AND LOWER(annualsalary) LIKE '%stock%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT
      
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonuses' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%sales%'
      AND LOWER(annualsalary) LIKE '%k%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',1),'[^0-9]*','','g')::FLOAT +
      REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',2),'[^0-9]*','','g')::FLOAT * 1000
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonuses' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%inc.%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonuses' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%k + $%'
      THEN (REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',1),'[^0-9]*','','g')::FLOAT +
      REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',2),'[^0-9]*','','g')::FLOAT) * 1000
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%hr%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',1),'[^0-9]*','','g')::FLOAT*40*52 +
          REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',2),'[^0-9]*','','g')::FLOAT  
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND (LOWER(annualsalary) LIKE '%w/%' OR LOWER(annualsalary) LIKE '%3x%')
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%-%'
      AND LOWER(annualsalary) LIKE '%k%'
      AND (LOWER(annualsalary) LIKE '%btwn%' OR LOWER(annualsalary) LIKE '%then%')
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT +
          (REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'bonus',2),'-',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'bonus',2),'-',2),'[^0-9]*','','g')::FLOAT)*500
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%plus%'
      AND LOWER(annualsalary) LIKE '%.%'
      AND LOWER(annualsalary) LIKE 'base%'
      THEN REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'plus',1),'.',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(annualsalary,'plus',2),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%plus%'
      AND LOWER(annualsalary) LIKE '%.%'
      AND LOWER(annualsalary) LIKE '%yr'
      THEN REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'plus',1),'.',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(annualsalary,'plus',2),'[^0-9]*','','g')::FLOAT*1000
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%plus%'
      AND (LOWER(annualsalary) LIKE '%k bonus%' OR LOWER(annualsalary) LIKE '%bonus ($%')
      AND LOWER(annualsalary) NOT LIKE '%-%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'plus',1),'[^0-9]*','','g')::FLOAT +
      REGEXP_REPLACE(SPLIT_PART(annualsalary,'plus',2),'[^0-9]*','','g')::FLOAT * 1000
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%appx%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'plus',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(annualsalary,'plus',2),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%including $%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'(',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(annualsalary,'(',2),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%base%'
      AND LOWER(annualsalary) LIKE '%grant'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT + 90000
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%base%'
      AND (LOWER(annualsalary) LIKE '%yearly%' OR annualsalary LIKE '%Base%')
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'bonus',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(annualsalary,'bonus',2),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%target%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT + 59182
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND (LOWER(annualsalary) LIKE '%stock' OR LOWER(annualsalary) LIKE '%max%' OR annualsalary LIKE '%Bonus.')
      AND (LOWER(annualsalary) LIKE '%k%' OR annualsalary LIKE '%Bonus.')
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',1),'[^0-9]*','','g')::FLOAT +
      REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',2),'[^0-9]*','','g')::FLOAT * 1000
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND LOWER(annualsalary) LIKE '%+%'
      AND LOWER(annualsalary) NOT LIKE '%k%'
      AND LOWER(annualsalary) NOT LIKE '%.%'
      AND LOWER(annualsalary) NOT LIKE '%-%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',1),'[^0-9]*','','g')::FLOAT +
      REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',2),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%bonus%' OR LOWER(annualsalary) LIKE '%bonus')
      AND annualsalary LIKE '%M'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT*1000 + 150000
      
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%.%'
      AND LOWER(annualsalary) NOT LIKE '$%'
      AND LOWER(annualsalary) NOT LIKE '%bonus%'
      AND LOWER(annualsalary) NOT LIKE '%bonus'
      AND LOWER(annualsalary) NOT LIKE '%bonuses'
      AND LOWER(annualsalary) NOT LIKE '%bonuses%'
      AND LOWER(annualsalary) NOT LIKE '%hou%'
      AND LOWER(annualsalary) NOT LIKE '%an%'
      AND LOWER(annualsalary) NOT LIKE '%hr'
      AND LOWER(annualsalary) NOT LIKE '%hr%'
      AND LOWER(annualsalary) NOT LIKE '%\%%'
      AND LOWER(annualsalary) NOT LIKE '%k'
      AND LOWER(annualsalary) NOT LIKE '%in%'
      AND LOWER(annualsalary) NOT LIKE '%fte'
      AND LOWER(annualsalary) NOT LIKE 'average%'
      AND LOWER(annualsalary) NOT LIKE '%on%'
      AND LENGTH(annualsalary) >6
      AND LOWER(annualsalary) NOT LIKE '%overtime%'
      AND LOWER(annualsalary) NOT LIKE '%.00%'
      AND LOWER(annualsalary) NOT LIKE 'approx%'
      AND LOWER(annualsalary) NOT LIKE '42.348%'
      AND LOWER(annualsalary) NOT LIKE '91.553%'
      AND LOWER(annualsalary) NOT LIKE '44.387%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',2),'[^0-9]*','','g')::FLOAT/100
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%.%'
      AND (LOWER(annualsalary) LIKE '42.348%' OR LOWER(annualsalary) LIKE '44.387%' OR LOWER(annualsalary) LIKE '91.553%')
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',1),'[^0-9]*','','g')::FLOAT * 1000 +
           REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',2),'[^0-9]*','','g')::FLOAT +
           REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',3),'[^0-9]*','','g')::FLOAT/100
           
      WHEN currency = 'USD'    
      AND LOWER(annualsalary) LIKE '%.%'
      AND LOWER(annualsalary) NOT LIKE '$%'
      AND LOWER(annualsalary) LIKE '%hour)%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD' 
      AND LOWER(annualsalary) LIKE '%.%'
      AND LOWER(annualsalary) LIKE '%hour%'
      AND LOWER(annualsalary) LIKE 'about%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,',',1),'[^0-9]*','','g')::FLOAT * 1000
      
      WHEN currency = 'USD' 
      AND LOWER(annualsalary) LIKE '%.%'
      AND LOWER(annualsalary) LIKE '%hour%'
      AND LOWER(annualsalary)  LIKE '%an%'
      AND LOWER(annualsalary)  LIKE '%/%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'/',1),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD' 
      AND LOWER(annualsalary) LIKE '%.%'
      AND LOWER(annualsalary) LIKE '%hour%'
      AND LOWER(annualsalary)  LIKE '%an%'
      AND LOWER(annualsalary)  LIKE 'part%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'an',1),'[^0-9]*','','g')::FLOAT * 28 * 52
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%.%'
      AND LOWER(annualsalary) LIKE '%\%%'
      THEN 65000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%.%'
      AND LOWER(annualsalary) LIKE '%-%'
      AND LOWER(annualsalary) LIKE '%worked%'
      THEN 47.5 * 40 * 52
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%.%'
      AND LOWER(annualsalary) LIKE '%-%'
      AND LOWER(annualsalary) LIKE '%easily%'
      THEN 127500
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%.%'
      AND (LOWER(annualsalary) LIKE '%k' OR LENGTH(annualsalary) <6)
      THEN (REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',1),'[^0-9]*','','g')::FLOAT +
           REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',2),'[^0-9]*','','g')::FLOAT/100) * 1000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%.%'
      AND LOWER(annualsalary) LIKE '%on%'
      AND LOWER(annualsalary) LIKE '%compensation%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',1),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%.%'
      AND LOWER(annualsalary) LIKE '%on%'
      AND LOWER(annualsalary) LIKE '%avg)'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',1),'[^0-9]*','','g')::FLOAT
     
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%.%'
      AND LOWER(annualsalary) LIKE 'average%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%.%'
      AND LOWER(annualsalary) LIKE '%fte'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%.%'
      AND LOWER(annualsalary) LIKE '%overtime%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'plus',1),'[^0-9]*','','g')::FLOAT +
           REGEXP_REPLACE(SPLIT_PART(annualsalary,'plus',2),'[^0-9]*','','g')::FLOAT
       
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%.%'    
      AND LOWER(annualsalary) LIKE '%.00'     
      AND LOWER(annualsalary) LIKE '%.500.%'
      THEN 37500
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%.%'
      AND annualsalary LIKE '%USD'
      THEN 80000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%.%'
      AND LENGTH(annualsalary) = 6
      THEN (REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',1),'[^0-9]*','','g')::FLOAT +
           REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',2),'[^0-9]*','','g')::FLOAT/1000) * 1000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%.%'
      AND annualsalary LIKE 'Approx.%'
      THEN 36500
      
      WHEN currency = 'USD'
      AND LENGTH(annualsalary) = 3  
      AND LOWER(annualsalary) NOT LIKE 'n/a'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 1000
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE 'n/a' OR LOWER(annualsalary) LIKE 'na' 
          OR LOWER(annualsalary) LIKE 'f' OR LOWER(annualsalary) LIKE 'b' OR LOWER(annualsalary) LIKE '$0')
      THEN 0
      
      WHEN currency = 'USD'
      AND LENGTH(annualsalary) < 3  
      AND LOWER(annualsalary) NOT LIKE 'n/a'
      AND LOWER(annualsalary) NOT LIKE 'na'
      AND LOWER(annualsalary) NOT LIKE 'f'
      AND LOWER(annualsalary) NOT LIKE 'b'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 1000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '1 million'
      THEN 1000000
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%,oo%' OR LOWER(annualsalary) LIKE '$85 thousand')
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 1000
      
      WHEN currency = 'USD' 
      AND annualsalary LIKE '%OTE%'
      AND annualsalary LIKE '%Commission'
      THEN 110000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE 'varies from%'
      THEN 40000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE 'part time, base%'
      THEN 54 * 40 * 52
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%-%'
      AND LOWER(annualsalary) NOT LIKE '%00-900%'
      AND LOWER(annualsalary) NOT LIKE '%in%'
      AND LOWER(annualsalary) NOT LIKE '%take%'
      AND LOWER(annualsalary) NOT LIKE '%plus%'
      AND LOWER(annualsalary) NOT LIKE '%pre%'
      AND LOWER(annualsalary) NOT LIKE '%per%'
      AND LOWER(annualsalary) NOT LIKE 'between%'
      AND LOWER(annualsalary) NOT LIKE '%k%'
      AND LOWER(annualsalary) NOT LIKE '25-35%'
      THEN (REGEXP_REPLACE(SPLIT_PART(annualsalary,'-',1),'[^0-9]*','','g')::FLOAT +
           REGEXP_REPLACE(SPLIT_PART(annualsalary,'-',2),'[^0-9]*','','g')::FLOAT)/2
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%year' OR LOWER(annualsalary) LIKE '%taxes)'
          OR LOWER(annualsalary) LIKE '%+' OR LOWER(annualsalary) LIKE '%(net)'
          OR LOWER(annualsalary) LIKE '%plus commission' OR LOWER(annualsalary) LIKE '%k/yr'
          OR LOWER(annualsalary) LIKE '%overtime)')
      AND LOWER(annualsalary) LIKE '%k%'
      AND LOWER(annualsalary) NOT LIKE '%$150/%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 1000
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%/yr' OR LOWER(annualsalary) LIKE '%summer'
           OR LOWER(annualsalary) LIKE '%per year' OR LOWER(annualsalary) LIKE '%base)'
           OR LOWER(annualsalary) LIKE '%per year ')
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%/hour%' OR LOWER(annualsalary) LIKE '%/hour')
      AND LOWER(annualsalary) NOT LIKE '%/hourly or%'
      AND LOWER(annualsalary) NOT LIKE '%$150%'
      AND LOWER(annualsalary) NOT LIKE '22/hour%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 40 * 52
      
      WHEN currency = 'USD'
      AND (LOWER(annualsalary) LIKE '%overtime)' OR LOWER(annualsalary) LIKE '%per week)' )
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%00-900%'
      THEN 700000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%base%'
      AND LOWER(annualsalary) NOT LIKE '%roughly%'
      AND LOWER(annualsalary) NOT LIKE '%double%'
      AND LOWER(annualsalary) NOT LIKE '%all-in%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'base',1),'[^0-9]*','','g')::FLOAT + 
           REGEXP_REPLACE(SPLIT_PART(annualsalary,'base',2),'[^0-9]*','','g')::FLOAT
           
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%about double%'
      THEN 54000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE 'between 15%'
      THEN 200000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%plus commissions (%'
      THEN 255000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%plus tips%'
      THEN 74560
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%be closer%'
      THEN 90000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%roughly%'
      THEN 160500
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '25-35,%'
      THEN 30000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '40k salary%'
      THEN 60000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%health insurance%'
      THEN 38200
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%more'
      THEN 98000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%in overtime'
      THEN 180000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%-40k)'
      THEN 130000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%making it%'
      THEN 75000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%new job, went%'
      THEN 125000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '% / %'
      THEN 65000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%the project budget'
      THEN 92500
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%in incentive%'
      THEN 78000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE 'hourly,%'
      THEN 38000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%all-in)'
      THEN 250000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%to year)'
      THEN 45000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%commissions possible)'
      THEN 1000000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%(take-home%'
      THEN 30000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%10ish%'
      THEN 42000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%ss 2018)'
      THEN 8838
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '$\%%'
      THEN 2000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '22/hour%'
      THEN 45000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '11/hour%'
      THEN 30680
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '16,500 for part%'
      THEN 16500
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '%00–50,%'
      THEN 45000
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '$15/hour%'
      THEN 31200
      
      WHEN currency = 'USD'
      AND LOWER(annualsalary) LIKE '~27,600,%'
      THEN 25116
    
    
    WHEN currency = 'AUD/NZD' 
  AND LOWER(annualsalary) NOT LIKE '%k%'
  AND LOWER(annualsalary) NOT LIKE '%k'
  AND LOWER(annualsalary) NOT LIKE '%.%'
  AND LOWER(annualsalary) NOT LIKE '%hour'
  AND LOWER(annualsalary) NOT LIKE '%-%'
  AND LENGTH(annualsalary) > 3
  THEN  REGEXP_REPLACE(annualsalary, '[^0-9]*','','g')::FLOAT * 0.73
  
  WHEN currency = 'AUD/NZD'
  AND LOWER(annualsalary) LIKE '%.%'
  AND LOWER(annualsalary) NOT LIKE '%hr%'
  AND LOWER(annualsalary) NOT LIKE '%.'
  AND LENGTH(annualsalary) != 6
  THEN  (REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',1), '[^0-9]*','','g')::FLOAT+
        REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',2), '[^0-9]*','','g')::FLOAT/100) * 0.73
        
  WHEN currency = 'AUD/NZD'
  AND LOWER(annualsalary) LIKE '%hr%'
  THEN (REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',1), '[^0-9]*','','g')::FLOAT+
        REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',2), '[^0-9]*','','g')::FLOAT/100) * 0.73 * 40 * 52
        
  WHEN currency = 'AUD/NZD'     
  AND LOWER(annualsalary) LIKE '%k'
  THEN REGEXP_REPLACE(annualsalary, '[^0-9]*','','g')::FLOAT * 0.73 * 1000
  
  WHEN currency = 'AUD/NZD'
  AND LOWER(annualsalary) LIKE '%k%'
  AND LOWER(annualsalary) NOT LIKE '%k'
  AND LOWER(annualsalary) NOT LIKE '%to%'
  AND LOWER(annualsalary) NOT LIKE '%work%'
  THEN REGEXP_REPLACE(annualsalary, '[^0-9]*','','g')::FLOAT * 0.73 * 1000
  
  WHEN currency = 'AUD/NZD'
  AND LOWER(annualsalary) LIKE '%k%'
  AND LOWER(annualsalary)  LIKE '%to%'
  AND LOWER(annualsalary) NOT  LIKE '%total%'
  THEN (REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'not',1),'to',1), '[^0-9]*','','g')::FLOAT+
        REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'not',1),'to',2), '[^0-9]*','','g')::FLOAT)* 500 * 0.73
        
  WHEN currency = 'AUD/NZD'
  AND LOWER(annualsalary) LIKE '%k%'
  AND LOWER(annualsalary)  LIKE '%to%'
  AND LOWER(annualsalary) LIKE '%total%'
  THEN 70000 * 0.73
  
  WHEN currency = 'AUD/NZD'
  AND LOWER(annualsalary) LIKE '%-%'
  THEN (REGEXP_REPLACE(SPLIT_PART(annualsalary,'-',1), '[^0-9]*','','g')::FLOAT+
        REGEXP_REPLACE(SPLIT_PART(annualsalary,'-',2), '[^0-9]*','','g')::FLOAT)*0.365
        
  WHEN currency = 'AUD/NZD'
  AND LOWER(annualsalary) LIKE '%.'
  THEN  REGEXP_REPLACE(annualsalary, '[^0-9]*','','g')::FLOAT * 0.73
  
  WHEN currency = 'AUD/NZD'
  AND LENGTH(annualsalary) < 4
  AND LOWER(annualsalary) NOT LIKE '%k'
  THEN  REGEXP_REPLACE(annualsalary, '[^0-9]*','','g')::FLOAT * 0.73 * 1000
  
  WHEN currency = 'AUD/NZD'
  AND annualsalary LIKE '$96.00'
  THEN 96000 * 0.73
  
  WHEN currency = 'AUD/NZD'
  AND LOWER(annualsalary) LIKE '%hour'
  THEN  REGEXP_REPLACE(annualsalary, '[^0-9]*','','g')::FLOAT * 0.73 * 40 * 52
  
  WHEN currency = 'EUR' AND LOWER(annualsalary) NOT LIKE '%salary%'
      AND LOWER(annualsalary) NOT LIKE '%net%'
      AND LOWER(annualsalary) NOT LIKE '%k%'
      AND LOWER(annualsalary) NOT LIKE '%€%'
      AND LOWER(annualsalary) NOT LIKE '%eur'
      AND LOWER(annualsalary) NOT LIKE '%depending%'
      AND LOWER(annualsalary) NOT LIKE '%month%'
      AND LOWER(annualsalary) NOT LIKE '%/h%'
      AND LOWER(annualsalary) NOT LIKE '%overtime%'
      AND LOWER(annualsalary) NOT LIKE '%boss%'
      AND (LENGTH(annualsalary) !=2)
      AND (LENGTH(annualsalary) !=3)
      THEN REPLACE(REPLACE(annualsalary,',',''),' ','')::FLOAT * 1.18
  
  WHEN currency = 'EUR'
      AND (LENGTH(annualsalary) =2 OR LENGTH(annualsalary) =3)
      THEN REGEXP_REPLACE(annualsalary, '[^0-9]*','','g')::FLOAT * 1000 * 1.18
      
  WHEN currency = 'EUR'
      AND LOWER(annualsalary) LIKE '%k%'
      AND LOWER(annualsalary) NOT LIKE '%+%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',1), '[^0-9]*','','g')::FLOAT * (1000) * (1.18)
      
  WHEN currency = 'EUR'
    AND LOWER(annualsalary) LIKE '%k%'
    AND LOWER(annualsalary) LIKE '%+%'
    AND LOWER(annualsalary) LIKE '%brut%'
    THEN SPLIT_PART(SPLIT_PART(annualsalary,'(',1),'.',1)::FLOAT * (1000) * (1.18) + REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'(',1),'.',2),'[^0-9]*','','g')::FLOAT * (100) * (1.18)
    
  WHEN currency = 'EUR'
    AND LOWER(annualsalary) LIKE '%k%'
    AND LOWER(annualsalary) LIKE '%+%'
    AND LOWER(annualsalary) LIKE '%%%'
    THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',1),'[^0-9]*','','g')::FLOAT*1000*1.18 * (1+(REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',2),'[^0-9]*','','g')::FLOAT/100))
    
  WHEN currency = 'EUR'
    AND LOWER(annualsalary) LIKE '%month%'
    THEN REGEXP_REPLACE(annualsalary, '[^0-9]*','','g') ::FLOAT* (12) *(1.18)
    
  WHEN currency = 'EUR'
    AND LOWER(annualsalary) LIKE '%€%'
    AND LOWER(annualsalary) NOT LIKE '%hour%'
    THEN REPLACE(REPLACE(annualsalary,'€',''),',','')::FLOAT *1.18
    
  WHEN currency = 'EUR'
    AND (LOWER(annualsalary) LIKE '%hour%' OR LOWER(annualsalary) LIKE ('%h'))
    THEN REGEXP_REPLACE(annualsalary, '[^0-9]*','','g') ::FLOAT* (8) * (5) *(52) *(1.18)
    
  WHEN currency = 'EUR'
    AND (LOWER(annualsalary) LIKE '%net%' OR LOWER(annualsalary) LIKE ('%depending%') OR LOWER(annualsalary) LIKE ('%overtime%'))
    THEN LEFT(REGEXP_REPLACE(annualsalary, '[^0-9]*','','g'),5)::FLOAT * 1.18
     
  WHEN currency = 'EUR'
      AND LOWER(annualsalary) LIKE '%eur'
      THEN REGEXP_REPLACE(annualsalary, '[^0-9]*','','g')::FLOAT *1.18
      
  WHEN currency = 'SEK'
      AND LOWER(annualsalary) LIKE '%/month'
      THEN REGEXP_REPLACE(annualsalary, '[^0-9]*','','g') ::FLOAT* (12) * 0.11
      
  WHEN currency = 'SEK'
      AND LOWER(annualsalary) LIKE '%/hour%'
      THEN REGEXP_REPLACE(annualsalary, '[^0-9]*','','g') ::FLOAT* (8) * (5) * (52) * 0.11
      
  WHEN currency = 'SEK'
      THEN REGEXP_REPLACE(annualsalary, '[^0-9]*','','g')::FLOAT *0.11
  
  WHEN currency = 'ZAR'
    AND LOWER(annualsalary) NOT LIKE '%e%'
    THEN REPLACE(REPLACE(annualsalary,',',''),'R','')::FLOAT *0.060
    
  WHEN currency = 'ZAR'
    AND LOWER(annualsalary) LIKE '%e%'
    THEN 1360000
  
  WHEN currency = 'CAD'
      AND LOWER(annualsalary) NOT LIKE '%$%'
      AND LOWER(annualsalary) NOT LIKE '%-%'
      AND LOWER(annualsalary) NOT LIKE '%k%'
      AND LOWER(annualsalary) NOT LIKE '%.%'
      AND LOWER(annualsalary) NOT LIKE '%plus%'
      AND LOWER(annualsalary) NOT LIKE '%to%'
      AND LOWER(annualsalary) NOT LIKE '%but%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.79
    
  WHEN currency = 'CAD'
      AND (LOWER(annualsalary) LIKE '%hour%' OR LOWER(annualsalary) LIKE ('%h') OR LOWER(annualsalary) LIKE ('%hr%'))
      AND LOWER(annualsalary) NOT LIKE '%week'
      AND LOWER(annualsalary) NOT LIKE '%hours%'
      AND LOWER(annualsalary) NOT LIKE 'around%'
      THEN REGEXP_REPLACE(annualsalary, '[^0-9]*','','g') ::FLOAT* (8) * (5) *(52) *(0.79)
    
  WHEN currency = 'CAD'
    AND LOWER(annualsalary) LIKE '%week'
    THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1), '[^0-9]*','','g') ::FLOAT* 35 *(52) *(0.79) 
    
  WHEN currency = 'CAD'
    AND LOWER(annualsalary) LIKE '%hours%'
    THEN (SPLIT_PART(SPLIT_PART(annualsalary,' ',1),'-',1)::FLOAT*(0.79) + SPLIT_PART(SPLIT_PART(annualsalary,' ',1),'-',2)::FLOAT*(0.79))/2
  
  WHEN currency = 'CAD'
      AND LOWER(annualsalary) LIKE '%base%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'base',1),'[^0-9]*','','g')::FLOAT * 0.79 + 
              REGEXP_REPLACE(SPLIT_PART(annualsalary,'base',2),'[^0-9]*','','g')::FLOAT * 0.79
  
  WHEN currency = 'CAD'
      AND (LOWER(annualsalary) LIKE '%$' OR LOWER(annualsalary) LIKE '$%' OR LOWER(annualsalary) LIKE '%$%')
      AND LOWER(annualsalary) NOT LIKE '%.%'
      AND LOWER(annualsalary) NOT LIKE '%avg%'
      AND LOWER(annualsalary) NOT LIKE '%k'
      AND LOWER(annualsalary) NOT LIKE 'around%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.79
  
  WHEN currency = 'CAD'
      AND LOWER(annualsalary) LIKE '%k'
      AND LOWER(annualsalary) NOT LIKE '%week'
      AND LOWER(annualsalary) NOT LIKE 'around%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.79 * 1000
  
  WHEN currency = 'CAD'
      AND LOWER(annualsalary) LIKE 'around%'
      AND LOWER(annualsalary) NOT LIKE '%.000'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',2),'[^0-9]*','','g')::FLOAT * 0.79 * 1000
  
  WHEN currency = 'CAD'
      AND LOWER(annualsalary) LIKE '% - %'
      AND LOWER(annualsalary) NOT LIKE '%avg%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'-',2),'[^0-9]*','','g')::FLOAT * 0.79
  
      WHEN currency = 'CAD'
      AND LOWER(annualsalary) LIKE '%.%'
      AND LOWER(annualsalary) NOT LIKE '%.'
      AND LOWER(annualsalary) NOT LIKE '%-%'
      AND LOWER(annualsalary) NOT LIKE '%hr%'
      THEN (REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',1),'[^0-9]*','','g')::FLOAT +
          REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',2),'[^0-9]*','','g')::FLOAT/100)*0.79
          
      WHEN currency = 'CAD'
      AND LOWER(annualsalary) LIKE '%.'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.79
      
      WHEN currency = 'CAD'
      AND LOWER(annualsalary) LIKE '% (variable; depends%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.79 * 1000
      
      WHEN currency = 'CAD'
      AND LOWER(annualsalary) LIKE '%-%'
      AND LOWER(annualsalary) LIKE '%avg.%'
      THEN 41500 * 0.79
      
  WHEN currency = 'CAD'
      AND LOWER(annualsalary) LIKE '%plus%'
      AND LOWER(annualsalary) LIKE '%bonus%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'plus', 1),'[^0-9]*','','g')::FLOAT * 0.79 + 
        REGEXP_REPLACE(SPLIT_PART(annualsalary,'plus', 2),'[^0-9]*','','g')::FLOAT * 0.79 +
        REGEXP_REPLACE(SPLIT_PART(annualsalary,'plus', 3),'[^0-9]*','','g')::FLOAT * 0.79 
  
  WHEN currency = 'GBP'
      AND LOWER(annualsalary) NOT LIKE '£%'
      AND LOWER(annualsalary) NOT LIKE '%k'
      AND LOWER(annualsalary) NOT LIKE '%.%'
      AND LOWER(annualsalary) NOT LIKE '%discretionary%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 1.33
      
  WHEN currency = 'GBP'
      AND LOWER(annualsalary) LIKE '%k'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 1.33 * 1000
      
  WHEN currency = 'GBP'
      AND (LOWER(annualsalary) LIKE '£%' OR LOWER(annualsalary) LIKE '%plus%')
      AND LOWER(annualsalary) NOT LIKE '%and%'
      AND LOWER(annualsalary) NOT LIKE '%.%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 1.33
      
  WHEN currency = 'GBP'
      AND LOWER(annualsalary) LIKE '%and%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',1),'[^0-9]*','','g')::FLOAT * 1.33    
      
  WHEN currency = 'GBP'
      AND LOWER(annualsalary) LIKE '%.%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',1),'[^0-9]*','','g')::FLOAT * 1.33
  
  WHEN currency = 'GBP'
    AND (LOWER(annualsalary) LIKE '%hour' OR LOWER(annualsalary) LIKE ('%h'))
    AND LOWER(annualsalary) NOT LIKE '%week'
    THEN REGEXP_REPLACE(annualsalary, '[^0-9]*','','g') ::FLOAT* (8) * (5) *(52) *(1.33)
    
  WHEN currency = 'GBP'
    AND LOWER(annualsalary) LIKE '%week'
    THEN REGEXP_REPLACE(annualsalary, '[^0-9]*','','g') ::FLOAT* (7) * (5) *(52) *(1.33) 
    
  WHEN currency = 'GBP'
    AND LOWER(annualsalary) LIKE '%+%'
    AND LOWER(annualsalary) LIKE '%discretionary%'
    THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',1),'[^0-9]*','','g')::FLOAT * 1.33 * (1+(REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',2),'[^0-9]*','','g')::FLOAT/100))
    
  WHEN currency = 'JPY'
      AND LOWER(annualsalary) NOT LIKE '%million%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.0096  
      
  WHEN currency = 'JPY'
      AND LOWER(annualsalary) LIKE '%bonus%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',1),'[^0-9]*','','g')::FLOAT * 0.0096 + REGEXP_REPLACE(SPLIT_PART(annualsalary,'+',2),'[^0-9]*','','g')::FLOAT * 0.0096 * 1000000
     
  WHEN currency = 'JPY'
      AND LOWER(annualsalary) LIKE '%from%'
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,' ',8),'[^0-9]*','','g')::FLOAT * 0.0096 * 1000000
       
  WHEN currency = 'CHF'
      AND LOWER(annualsalary) NOT LIKE '%bonus%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 1.13
  
  WHEN currency = 'CHF'
      AND LOWER(annualsalary) LIKE '%shares%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 1.13
  
  WHEN currency = 'CHF'
      AND LOWER(annualsalary) LIKE '%+%'
      THEN REPLACE(SPLIT_PART(annualsalary,'+', 1),'K','')::FLOAT *1.13*1000 + 
          REGEXP_REPLACE(SPLIT_PART(SPLIT_PART(annualsalary,'+', 2),'-',2),'[^0-9]*','','g')::FLOAT *1.13*1000
  
  WHEN currency = 'HKD'
  
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.13
      
  WHEN currency = 'Other'
       AND (LOWER(citystatecountry) LIKE '%india%' OR LOWER(citystatecountry) LIKE 'india%' 
           OR LOWER(citystatecountry) LIKE '%india' OR LOWER(citystatecountry) LIKE 'bangalore'
           OR LOWER(citystatecountry) LIKE 'bengaluru' OR LOWER(citystatecountry) LIKE 'mumbai'
           OR LOWER(citystatecountry) LIKE 'delhi')
       AND  annualsalary NOT LIKE '%rupees'
       THEN  REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.014 
       
       WHEN currency = 'Other'
       AND annualsalary LIKE '%rupees'
      THEN  REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.014 * 40 * 52
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'chile' OR LOWER(citystatecountry) LIKE '%chile')
      THEN annualsalary::FLOAT * 0.0014
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'mexico' OR LOWER(citystatecountry) LIKE '%mexico' 
            OR LOWER(citystatecountry) LIKE '%mexico%')
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.050
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%norway' OR LOWER(citystatecountry) LIKE 'norway' ) 
      AND LOWER(annualsalary) NOT LIKE '%.%' 
      AND LENGTH(annualsalary) > 3
      THEN annualsalary::FLOAT * 0.12
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%norway' OR LOWER(citystatecountry) LIKE 'norway' ) 
      AND LOWER(annualsalary) LIKE '%.%' 
      THEN REGEXP_REPLACE(SPLIT_PART(annualsalary,'.',1),'[^0-9]*','','g')::FLOAT * 0.12
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'norway' 
      AND LENGTH(annualsalary) < 4
      THEN annualsalary::FLOAT * 0.12 * 1000
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'denmark' OR LOWER(citystatecountry) LIKE 'copenhagen') 
      AND LENGTH(annualsalary) > 3
      THEN annualsalary::FLOAT * 0.16
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'denmark' 
      AND LENGTH(annualsalary) < 4
      THEN annualsalary::FLOAT * 0.16 * 1000
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'switzerland%'
      THEN annualsalary::FLOAT * 1.12
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'sri lanka'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.0053
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'israel' OR LOWER(citystatecountry) LIKE '%israel')
      AND LOWER(annualsalary) LIKE '$%'
      THEN 32000
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'israel' OR LOWER(citystatecountry) LIKE '%israel')
      AND LOWER(annualsalary) NOT LIKE '$%'
       THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.31 
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'trinidad and tobago' 
      THEN 193000 * 0.15
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%poland' OR LOWER(citystatecountry) LIKE 'poland%') 
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.27
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE '%hungary' 
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.0033
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'argentina'
      AND LOWER(annualsalary) LIKE '%,%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.012
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'argentina'
      AND LOWER(annualsalary) LIKE '%.%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.012
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'philippines' OR LOWER(citystatecountry) LIKE '%philippines')
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.021
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'malaysia' OR LOWER(citystatecountry) LIKE '%malaysia'
         OR LOWER(citystatecountry) LIKE 'kuala lumpur'  OR LOWER(citystatecountry) LIKE 'kuala')
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.25
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'singapore' OR LOWER(citystatecountry) LIKE '%singapore'
          OR LOWER(citystatecountry) LIKE 'sgp') 
      AND LOWER(annualsalary) NOT LIKE '%k'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.75
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'singapore' OR LOWER(citystatecountry) LIKE '%singapore') 
      AND LOWER(annualsalary) LIKE '%k'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.75 * 1000
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%korea' OR LOWER(citystatecountry) LIKE 'seoul%' )
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.00091
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%canada' OR LOWER(citystatecountry) LIKE 'mississauga' )
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.78
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE '%qatar' 
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.27
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE '%indonesia' 
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.000071
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE '%thailand' 
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.033
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%czech%' OR LOWER(citystatecountry) LIKE 'czech%' 
          OR LOWER(citystatecountry) LIKE 'cz') 
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.046
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE '%south africa'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.069
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%australia' OR LOWER(citystatecountry) LIKE 'sydney')
      AND LOWER(annualsalary) NOT LIKE '%k'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.76
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE '%australia '
      AND LOWER(annualsalary)  LIKE '%$%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.76
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE '%australia'
      AND LOWER(annualsalary) LIKE '%k'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.76 * 1000
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%brazil' OR LOWER(citystatecountry) LIKE 'brazil'
            OR LOWER(citystatecountry) LIKE 'sao paulo') 
      AND LOWER(annualsalary) NOT LIKE '%.%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.19
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%brazil' OR LOWER(citystatecountry) LIKE 'brazil' ) 
      AND LOWER(annualsalary) LIKE '%.%'
      THEN 146640 * 0.19
      
       WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%taiwan' OR LOWER(citystatecountry) LIKE 'taiwan' 
          OR LOWER(citystatecountry) LIKE 'taipe%' ) 
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.036
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'novosibirsk' OR LOWER(citystatecountry) LIKE '%russia'
          OR LOWER(citystatecountry) LIKE 'russia%') 
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.014
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%turkey' OR LOWER(citystatecountry) LIKE 'istanbul' )
      AND LENGTH(annualsalary) < 3
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.13 * 1000
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%turkey' OR LOWER(citystatecountry) LIKE 'istanbul' )
      AND LENGTH(annualsalary) > 3
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.13 
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE '%colombia'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.00029
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'bahrain'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 2.65
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'kyiv'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.035
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE '%zealand'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.71
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'lagos' OR LOWER(citystatecountry) LIKE 'nigeria')
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.0026
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'northampton%'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 1.35
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'bulgaria'
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.62
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%barbados' OR LOWER(citystatecountry) LIKE 'caribbean')
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.37
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'oman' )
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 2.60
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'dubai' )
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.27
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'kenya' )
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.0092
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%nepal' )
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.0085
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'iceland' )
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.0078
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'philadelphia' )
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT 
      
       WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'hamilton bda' )
      THEN REGEXP_REPLACE(annualsalary,'[^0-9]*','','g')::FLOAT * 0.012 * 1000
END as "Salary",

CASE 
  WHEN citystatecountry LIKE '%,%'
  THEN RTRIM(SPLIT_PART(citystatecountry,',', 1))
   
  WHEN citystatecountry LIKE '%/%'
  THEN RTRIM(SPLIT_PART(citystatecountry,'/', 1))
      
  WHEN currency = 'ZAR'
        AND citystatecountry NOT LIKE '%,%'
        AND citystatecountry NOT LIKE '%/%'
        THEN 'South Africa'
        
  WHEN currency  = 'AUD/NZD'
      AND citystatecountry NOT LIKE '%,%'
      AND citystatecountry NOT LIKE '%/%'
      AND citystatecountry  LIKE 'Australia'
      THEN 'Australia'
      
  WHEN currency  = 'AUD/NZD'
      AND citystatecountry NOT LIKE '%,%'
      AND citystatecountry NOT LIKE '%/%'
      AND citystatecountry  LIKE 'New Zealand'
      THEN 'New Zealand'
    
  ELSE RTRIM(SPLIT_PART(citystatecountry,' ', 1))
   
  END as "City",
  CASE WHEN currency = 'USD'
        THEN 'USA'
        
      WHEN currency = 'GBP'
      THEN 'UK'
      
      WHEN currency = 'ZAR'
      THEN 'South Africa'
      
      WHEN currency = 'CHF'
      THEN 'Switzerland'
      
      WHEN currency = 'CAD'
      THEN 'Canada'
      
      WHEN currency = 'SEK'
      THEN 'Sweden'
      
      WHEN currency = 'JPY'
      THEN 'Japan'
      
      WHEN currency = 'HKD'
      THEN 'Hong Kong'
      
      WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%italy' OR LOWER(citystatecountry) LIKE 'italy')
      THEN 'Italy'
      
      WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%belgium' OR LOWER(citystatecountry) LIKE 'belgium'
          OR LOWER(citystatecountry) LIKE 'brussels%')
      THEN 'Belgium'
      
      WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%finland' OR LOWER(citystatecountry) LIKE 'finland'
            OR LOWER(citystatecountry) LIKE 'finland%')
      THEN 'Finland'
      
       WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%ireland' OR LOWER(citystatecountry) LIKE 'ireland'
          OR LOWER(citystatecountry) LIKE '%ireland%' OR LOWER(citystatecountry) LIKE 'dublin')
      THEN 'Ireland'
      
       WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%germany' OR LOWER(citystatecountry) LIKE 'germany'
          OR LOWER(citystatecountry) LIKE 'berlin%' OR LOWER(citystatecountry) LIKE '%germany%'
          OR LOWER(citystatecountry) LIKE 'frankfurt'  OR LOWER(citystatecountry) LIKE 'munich'
          OR citystatecountry LIKE 'Lüneburg')
      THEN 'Germany'
      
       WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%austria' OR LOWER(citystatecountry) LIKE 'austria'
            OR LOWER(citystatecountry) LIKE 'vienna' OR LOWER(citystatecountry) LIKE '%austria%')
      THEN 'Austria'
      
       WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%netherlands' OR LOWER(citystatecountry) LIKE 'netherlands'
           OR LOWER(citystatecountry) LIKE 'rotterdam'  OR LOWER(citystatecountry) LIKE 'eindhoven'
           OR LOWER(citystatecountry) LIKE 'amsterdam'  OR LOWER(citystatecountry) LIKE '%netherlands%'
            OR LOWER(citystatecountry) LIKE 'nl' OR LOWER(citystatecountry) LIKE 'netherlands%')
      THEN 'Netherlands'
      
      WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%france' OR LOWER(citystatecountry) LIKE 'france'
            OR LOWER(citystatecountry) LIKE 'paris' OR LOWER(citystatecountry) LIKE 'france%'
            OR LOWER(citystatecountry) LIKE '%france%' OR LOWER(citystatecountry) LIKE 'montpellier')
      THEN 'France'
      
      WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%spain' OR LOWER(citystatecountry) LIKE 'spain'
           OR LOWER(citystatecountry) LIKE 'madrid')
      THEN 'Spain'
      
      WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%greece' OR LOWER(citystatecountry) LIKE 'greece')
      THEN 'Greece'
      
      WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%luxembourg' OR LOWER(citystatecountry) LIKE 'luxembourg')
      THEN 'Luxembourg'
      
      WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE 'czech%' )
      THEN 'Czech Republic'
      
      WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE 'lithuania%' )
      THEN 'Lithuania'
      
      WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE 'romania%' OR LOWER(citystatecountry) LIKE 'romania'
         OR LOWER(citystatecountry) LIKE '%romania')
      THEN 'Romania'
      
      WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE 'denmark' OR LOWER(citystatecountry) LIKE '%denmark' )
      THEN 'Denmark'
      
      WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE 'portugal' OR LOWER(citystatecountry) LIKE '%portugal' )
      THEN 'Portugal'
      
       WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%hungary' )
      THEN 'Hungary'
      
      WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%china' )
      THEN 'China'
      
      WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%serbia' )
      THEN 'Serbia'
      
      WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE 'estonia' )
      THEN 'Estonia'
      
       WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%croatia' OR LOWER(citystatecountry) LIKE 'prague' )
      THEN 'Croatia'
      
       WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%macedonia' )
      THEN 'Macedonia'
      
       WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%cyprus' )
      THEN 'Cyprus'
      
       WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE 'bulgaria' OR LOWER(citystatecountry) LIKE '%bulgaria' )
      THEN 'Bulgaria'
      
       WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%malta' OR LOWER(citystatecountry) LIKE 'malta' )
      THEN 'Malta'
      
      WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%thailand' )
      THEN 'Thailand'
      
       WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%latvia' )
      THEN 'Latvia'
      
      WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE '%ukraine' )
      THEN 'Ukraine'
      
      WHEN currency = 'EUR' AND (LOWER(citystatecountry) LIKE 'uk' )
      THEN 'UK'
      
      WHEN currency = 'EUR' AND LOWER(citystatecountry) LIKE 'chattanooga%' 
      THEN 'USA'
      
      WHEN currency = 'AUD/NZD' AND LOWER(citystatecountry) LIKE 'hamilton' 
      THEN 'USA'
      
      WHEN currency = 'AUD/NZD' AND (LOWER(citystatecountry) LIKE '%zealand' OR LOWER(citystatecountry) LIKE 'zl' 
          OR LOWER(citystatecountry) LIKE '%nz' OR LOWER(citystatecountry) LIKE 'whanganui%'
         OR LOWER(citystatecountry) LIKE 'wellington%' OR LOWER(citystatecountry) LIKE 'new ze%'
          OR LOWER(citystatecountry) LIKE 'palmerston%' OR LOWER(citystatecountry) LIKE 'new'
         OR LOWER(citystatecountry) LIKE 'blenhe%' OR LOWER(citystatecountry) LIKE 'auckland%'
         OR LOWER(citystatecountry) LIKE 'christchurch%' OR LOWER(citystatecountry) LIKE 'waikato')
      THEN 'New Zealand'
      
      WHEN currency = 'AUD/NZD' AND (LOWER(citystatecountry) LIKE '%australia' 
      OR LOWER(citystatecountry) LIKE 'australia' OR LOWER(citystatecountry) LIKE '%sydney'
      OR LOWER(citystatecountry) LIKE 'nsw' OR LOWER(citystatecountry) LIKE 'melbourne%'
      OR LOWER(citystatecountry) LIKE 'brisbane%' OR LOWER(citystatecountry) LIKE 'victoria%'
      OR LOWER(citystatecountry) LIKE 'sydney%' OR LOWER(citystatecountry) LIKE 'australia%'
      OR LOWER(citystatecountry) LIKE 'melboure%' OR LOWER(citystatecountry) LIKE 'canberra%'
      OR LOWER(citystatecountry) LIKE 'adelaide%' OR LOWER(citystatecountry) LIKE 'childers%'
      OR LOWER(citystatecountry) LIKE 'hobart%' OR LOWER(citystatecountry) LIKE 'perth%'
      OR LOWER(citystatecountry) LIKE 'ql%' OR LOWER(citystatecountry) LIKE 'queensland%'
      OR LOWER(citystatecountry) LIKE 'au%' OR LOWER(citystatecountry) LIKE 'ade'
      OR LOWER(citystatecountry) LIKE 'wanti%' OR LOWER(citystatecountry) LIKE 'tasma%'
      OR LOWER(citystatecountry) LIKE 'kwinana' OR LOWER(citystatecountry) LIKE 'nsww' 
      OR LOWER(citystatecountry) LIKE 'newman%' )
      THEN 'Australia'
      
       WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%nepal' )
      THEN 'Nepal'
      
  WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'kenya'
      THEN 'Kenya'
      
  WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'cape%'
      THEN 'South Africa'
  
  WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%brazil' OR LOWER(citystatecountry) LIKE 'brazil'
            OR LOWER(citystatecountry) LIKE 'sao paulo') 
     THEN 'Brazil'
      
       WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%taiwan' OR LOWER(citystatecountry) LIKE 'taiwan' 
          OR LOWER(citystatecountry) LIKE 'taipe%' ) 
      THEN 'Taiwan'
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'novosibirsk' OR LOWER(citystatecountry) LIKE '%russia'
          OR LOWER(citystatecountry) LIKE 'russia%') 
      THEN 'Russia'
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%turkey' OR LOWER(citystatecountry) LIKE 'istanbul' )
      THEN 'Turkey'
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE '%colombia'
      THEN 'Colombia'
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'bahrain'
      THEN 'Bahrain'
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'kyiv'
      THEN 'Ukraine'
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'lagos' OR LOWER(citystatecountry) LIKE 'nigeria')
      THEN 'Nigeria'
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'northampton%'
      THEN 'UK'
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'bulgaria'
      THEN 'Bulgaria'
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%barbados' OR LOWER(citystatecountry) LIKE 'caribbean')
      THEN 'West Caribbean'
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'oman' )
      THEN 'Oman'
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'dubai' )
      THEN 'UAE'
  
  WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'philadelphia' )
      THEN 'USA'
  
  WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'iceland' )
      THEN 'Iceland'
  
  WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'hamilton bda' )
      THEN 'Bermuda'
      
  WHEN currency = 'Other'
       AND (LOWER(citystatecountry) LIKE '%india%' OR LOWER(citystatecountry) LIKE 'india%' 
           OR LOWER(citystatecountry) LIKE '%india' OR LOWER(citystatecountry) LIKE 'bangalore'
           OR LOWER(citystatecountry) LIKE 'bengaluru' OR LOWER(citystatecountry) LIKE 'mumbai'
           OR LOWER(citystatecountry) LIKE 'delhi')
       THEN 'India'
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'chile' OR LOWER(citystatecountry) LIKE '%chile')
      THEN 'Chile'
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'mexico' OR LOWER(citystatecountry) LIKE '%mexico' 
            OR LOWER(citystatecountry) LIKE '%mexico%')
      THEN 'Mexico'
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%norway' OR LOWER(citystatecountry) LIKE 'norway' ) 
      THEN 'Norway'
      
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'denmark' OR LOWER(citystatecountry) LIKE 'copenhagen') 
      THEN 'Denmark'
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'switzerland%'
      THEN 'Switzerland'
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'sri lanka'
      THEN 'Sri Lanka'
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'israel' OR LOWER(citystatecountry) LIKE '%israel')
      THEN 'Israel'
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'trinidad and tobago' 
      THEN 'Trinidad and Tobago'
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%poland' OR LOWER(citystatecountry) LIKE 'poland%') 
      THEN 'Poland'
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE '%hungary' 
      THEN 'Hungary'
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'argentina'
      THEN 'Argentina'
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'philippines' OR LOWER(citystatecountry) LIKE '%philippines')
      THEN 'Philippines'
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'malaysia' OR LOWER(citystatecountry) LIKE '%malaysia'
         OR LOWER(citystatecountry) LIKE 'kuala lumpur'  OR LOWER(citystatecountry) LIKE 'kuala')
      THEN 'Malaysia'
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'singapore' OR LOWER(citystatecountry) LIKE '%singapore'
          OR LOWER(citystatecountry) LIKE 'sgp') 
      THEN 'Singapore'
      
      WHEN currency = 'AUD/NZD'
      AND (LOWER(citystatecountry) LIKE 'singapore') 
      THEN 'Singapore'
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%korea' OR LOWER(citystatecountry) LIKE 'seoul%' )
      THEN 'South Korea'
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%canada' OR LOWER(citystatecountry) LIKE 'mississauga' )
      THEN 'Canada'
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE '%qatar' 
      THEN 'Qatar'
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE '%indonesia' 
      THEN 'Indonesia'
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE '%thailand' 
      THEN 'Thailand'
      
      WHEN currency = 'AUD/NZD'
      AND LOWER(citystatecountry) LIKE '%thailand' 
      THEN 'Thailand'
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE '%czech%' OR LOWER(citystatecountry) LIKE 'czech%' 
          OR LOWER(citystatecountry) LIKE 'cz') 
      THEN 'Czech Republic'
      
      WHEN currency = 'Other'
      AND (LOWER(citystatecountry) LIKE 'melbourne%' OR LOWER(citystatecountry) LIKE 'sydney%'
          OR LOWER(citystatecountry) LIKE 'nsw%' OR LOWER(citystatecountry) LIKE 'nsww'
          OR LOWER(citystatecountry) LIKE 'newcastle,%')
      THEN 'Australia'
      
      WHEN currency = 'Other'
      AND LOWER(citystatecountry) LIKE 'wellington%' 
      THEN 'New Zealand'
      
      END AS "Country"
FROM thegradientboost.salarysurvey2019)



-- QUESTION 3

-- -- ASSIGNMENT => Monthly Average Income by Country
-- SELECT month, "Country", AVG("Salary") as Average_salary
-- from tableone
-- GROUP BY 1,2
-- ORDER BY  1 DESC,3 DESC

-- ASSIGNMENT => Annual Average Income by Country
-- SELECT year, "Country", AVG("Salary") as Average_salary
-- from tableone
-- GROUP BY 1,2
-- ORDER BY  1 DESC,3 DESC

-- -- ASSIGNMENT => Monthly Average Income by Country
-- SELECT month, "City", "Country", AVG("Salary") as Average_salary
-- from tableone
-- GROUP BY 2,1,3
-- ORDER BY  1 ,3 DESC

-- -- ASSIGNMENT => Annual Average Income by Country
-- SELECT "City", "Country", year, AVG("Salary") as Average_salary
-- from tableone
-- GROUP BY 2,1,3
-- ORDER BY 3 DESC

-- QUESTION 4

-- -- ASSIGNMENT =>  Average Income by Job Title
-- SELECT jobtitle, AVG("Salary") as Average_salary
-- from tableone
-- GROUP BY 1
-- ORDER BY 2 DESC

-- QUESTION 5

-- -- ASSIGNMENT =>  Average Income by Job Title
-- SELECT jobtitle, "Experience", AVG("Salary") as Average_salary
-- from tableone
-- GROUP BY 1,2
-- ORDER BY 2 DESC
