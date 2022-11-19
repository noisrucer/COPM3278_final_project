import React, { useState, useEffect } from "react";
import PropTypes from "prop-types";
import { Link } from "react-router-dom";
import styles from "./Information.module.css";
import Nav from "../components/NavSuccess";
var ReactDOM = require('react-dom');

function Information({
  studentId,
  courseId,
  courseName,
  subClassId,
  description,
  location,
  message,
  zoomLink,
  start,
  end,
  events,
  weekDay,
  loginToken,
  studentName,
  loginTime,
}) {
  // const link = "https://cf91-118-140-125-70.ap.ngrok.io/";
  const link = "http://localhost:8000/";
  const [loading, setLoading] = useState(false);
  const [status, setStatus] = useState(false);
  const [count, setCount] = useState(0);

  useEffect(() => {
    if (events != null) {
      setStatus(true);
    }
  });

  const capture = React.useCallback(() => {
    setLoading(true);
  });

  //   const updateCount = React.useCallback(() => {
  //     setCount((prevCount) => prevCount + 1);
  //   });

  useEffect(() => {
    console.log(studentId);
    console.log(courseId);
    console.log(courseName);
    console.log(subClassId);
    console.log(description);
    console.log(location);
    console.log(message);
    console.log(zoomLink);
    console.log(start);
    console.log(end);
    console.log(events);

    console.log(typeof studentId);
    const requestOptions = {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        student_id: studentId,
        course_id: courseId,
        subclass_id: subClassId,
        week_day: weekDay,
      }),
    };
    fetch(`${link}user/email_course_info`, requestOptions)
      .then((response) => {
        return response.json();
      })
      .then((data) => {
        console.log(data);
      });
  }, [loading]);

  useEffect(() => {}, [count]);

  return (
    <div>
      {status ? (
        <div>
          <Nav
            loginToken={loginToken}
            studentName={studentName}
            loginTime={loginTime}
          />

          <div className={styles.container}>
            <div className={styles.course_container}>
              <div className={styles.course_container_course}>
                <div className={styles.course_id}>{courseId}</div>
                <div className={styles.course_id_subclass}>{subClassId}</div>
              </div>
              <div className={styles.course_name}>{courseName}</div>
            </div>

            <div className={styles.course_bottom_container}>
              <div className={styles.course_basic}>
                <div className={styles.course_container_time}>
                  <div className={styles.course_container_time_box}>
                    <span>
                      <b>Start Time:</b> {start}
                    </span>
                    <span>
                      <b>End Time:</b> {end}
                    </span>
                    <span>
                      <b>Location:</b> {location}
                    </span>
                    <span>
                      <b>Zoom Link: </b>
                      <a
                        className={styles.link}
                        href={zoomLink}
                        target="_blank"
                        onClick={(e) => {
                          e.preventDefault();
                          const requestOptions = {
                            method: "POST",
                            headers: { "Content-Type": "application/json" },
                            body: JSON.stringify({
                              student_id: studentId,
                              type: "zoom_link",
                            }),
                          };
                          fetch(`${link}user/redirection`, requestOptions)
                            .then((response) => {
                              return response.json();
                            })
                            .then((data) => {
                              console.log(data);
                            });
                        }}
                      >
                        Lecture Zoom Link
                      </a>
                    </span>
                  </div>
                </div>
                <div className={styles.course_container_information}>
                  <div className={styles.course_title}>Course Information</div>
                  <div className={styles.course_intro}>{description}</div>
                </div>
                <div className={styles.course_container_announcement}>
                  <div className={styles.course_title}>Teacher's Message</div>
                  <div className={styles.course_message}>{message}</div>
                </div>
                <button
                  className={styles.button}
                  onClick={(e) => {
                    e.preventDefault();
                    capture();
                  }}
                >
                  Send Email
                </button>
              </div>

              <div>
                <div className={styles.course_events}>
                  {events.slice(0, 8).map((g) => (
                    <div className={styles.course_events_info}>
                      <div className={styles.course_events_info_specific}>
                        <span style={{ display: "none" }}>{g[0]}</span>
                        <span style={{ display: "none" }}> {g[1]}</span>
                        <span className={styles.course_ids}>
                          {g[2]}
                          {g[3]}
                        </span>
                        <span>
                          <b>Type:</b> {g[4]}
                        </span>
                        <span>
                          <b>Material: </b>
                          {g[5]}
                        </span>
                        <b>Download: </b>
                        <a
                          target="_blank"
                          href={g[6]}
                          onClick={(e) => {
                            console.log(g[0]);
                            console.log(g[1]);
                            const requestOptions = {
                              method: "POST",
                              headers: { "Content-Type": "application/json" },
                              body: JSON.stringify({
                                student_id: studentId,
                                subclass_event_id: g[0],
                                type: g[1],
                              }),
                            };
                            fetch(`${link}user/redirection`, requestOptions)
                              .then((response) => {
                                return response.json();
                              })
                              .then((data) => {
                                console.log(data);
                              });
                          }}
                        >
                          Link to Material
                        </a>
                        <span>
                          <b>Uploaded Time: </b>
                          {g[7]}
                        </span>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </div>
        </div>
      ) : null}
    </div>
  );
}
Information.propTypes = {
  studentId: PropTypes.string.isRequired,
  courseId: PropTypes.string.isRequired,
  courseName: PropTypes.string.isRequired,
  subClassId: PropTypes.string.isRequired,
  description: PropTypes.string.isRequired,
  location: PropTypes.string.isRequired,
  message: PropTypes.string.isRequired,
  zoomLink: PropTypes.string.isRequired,
  start: PropTypes.string.isRequired,
  end: PropTypes.string.isRequired,
  events: PropTypes.arrayOf(PropTypes.any).isRequired,
  weekDay: PropTypes.string.isRequired,
  loginToken: PropTypes.string.isRequired,
  studentName: PropTypes.string.isRequired,
  loginTime: PropTypes.string.isRequired,
};

export default Information;

/*

                          const tmp_requestOptions = {
                            method: "POST",
                            headers: { "Content-Type": "application/json" },
                            body: JSON.stringify({
                              from_location: "MWT2",
                              to_location: "CPD-LG.1",
                              time_section: 1,
                            }),
                          };
                          fetch(`${link}user/get_path`, tmp_requestOptions)
                            .then((response) => {
                              return response.json();
                            })
                            .then((data) => {
                              const SuccessImage = ({ data }) => <img src={`data:image/jpeg;base64,${data}`} />
                              ReactDOM.render(<SuccessImage data={data["map"]} />, document.getElementById('UserCameraDiv'))
                            });
                          return;

*/