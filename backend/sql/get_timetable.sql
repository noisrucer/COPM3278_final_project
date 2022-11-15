SELECT SI.course_id, SI.subclass_id, C.name, SI.week_day, SI.stime, SI.etime
FROM Subclass S JOIN Course C ON S.course_id = C.course_id
JOIN SubclassInfo SI ON SI.subclass_id = S.subclass_id AND SI.course_id = S.course_id
JOIN StudentEnrollsSubclass SE ON SE.course_id = S.course_id AND SE.subclass_id = S.subclass_id
WHERE SE.student_id = __STUDENT_ID__;

