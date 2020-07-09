--------------------------------------------------------------------------------------------------------------------------
-- Created By: Evan Lund
-- For: Cyberhill Partners, LLC.
-- Date: 3/27/2020
-- Description: A custom report for secret Server that will give us an audit view of a specific user for a specified time
--				range.
--------------------------------------------------------------------------------------------------------------------------
-- 3/27/2020 - Evan Lund - Create Custom Report
-- 4/29/2020 - Evan Lund - Updated Comments to match new format
---------------------------------------------------------------------------------------------------------------------------
SELECT ts.SecretName as [Secret Name],
	   tst.SecretTypeName as [Secret Template],
	   tf.FolderPath as [Folder Path],
	   tas.IpAddress as [IP Address],
	   tas.DateRecorded as [Date/Time],
	   tas.Action as [Action],
	   tas.Notes as [Notes],
	   Case when ts.active = 1 then 'Active' Else 'Deleted' End as [Status]
FROM [dbo].[tbAuditSecret] as tas
	 left join [dbo].[tbSecret] as ts on tas.SecretId = ts.SecretID
	 left join [dbo].[tbSecretType] as tst on ts.SecretTypeID = tst.SecretTypeID
	 left join [dbo].[tbFolder] as tf on ts.FolderId = tf.FolderID
Where tas.UserId = #USER
	  and tas.DateRecorded >= #StartDate
	  and tas.DateRecorded <= #EndDate
Order by tas.DateRecorded desc
