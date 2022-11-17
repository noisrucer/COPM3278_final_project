SELECT SE.subclass_event_id, SE.type, SE.course_id, SE.subclass_id, SE.type, SE.name, SE.hyperlink, SE.upload_time, SE.deadline
FROM SubclassEvent SE
WHERE SE.course_id = __COURSE_ID__ AND SE.subclass_id = __SUBCLASS_ID__;