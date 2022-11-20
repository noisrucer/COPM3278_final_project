import React, { useState, useEffect } from "react";
import Webcam from "react-webcam";
import axios from "axios";
import styles from "./Profile.module.css";
import { json } from "react-router-dom";
import Timetable from "./Timetable";
import Information from "./Information";
import Nav from "../components/NavUnsuccess";
var ReactDOM = require("react-dom");

const WebcamComponent = () => <Webcam />;
const videoConstraints = {
  width: 400,
  height: 400,
  facingMode: "user",
};
const Profile = () => {
  const [picture, setPicture] = useState("");
  const [loading, setLoading] = useState(false);
  const [studentId, setStudentId] = useState("");
  const [loginStatus, setLoginStatus] = useState(false);
  const [loginToken, setLoginToken] = useState("");
  const [loginTime, setLoginTime] = useState("");
  const [studentName, setStudentName] = useState("");
  const [timeTableData, setTimeTableData] = useState([]);
  const [classData, setClassData] = useState([]);
  const [type, setType] = useState(false);
  // const link = "https://cf91-118-140-125-70.ap.ngrok.io/";
  const link = "http://localhost:8000/";
  useEffect(() => {
    setLoading(true);
    setTimeout(() => {
      setLoading(false);
    }, 1000);
  }, []);

  const webcamRef = React.useRef(null);
  const capture = React.useCallback(() => {
    //console.log('Photo Taken!')
    const pictureSrc = webcamRef.current.getScreenshot();
    setPicture(pictureSrc);
    var today = new Date();
    var date =
      today.getFullYear() +
      "-" +
      (today.getMonth() + 1) +
      "-" +
      today.getDate();
    var time =
      today.getHours() +
      ":" +
      today.getMinutes() +
      ":" +
      today.getSeconds() +
      ":" +
      today.getMilliseconds();
    console.log(time);
    sleep(500);
    // var btnFaceRecognition = document.querySelector(".Profile_button__hwqUP");
    // console.log(btnFaceRecognition);
    // setInterval(function () {btnFaceRecognition.click();},500);
  });
  function sleep(milliseconds) {
    const date = Date.now();
    let currentDate = null;
    do {
      currentDate = Date.now();
    } while (currentDate - date < milliseconds);
  }

  useEffect(() => {
    console.log("Post to server");
    console.log(picture);
    //const data = JSON.stringify(picture)
    console.log(typeof picture);
    const requestOptions = {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ base64_encoded_img: picture }),
    };
    fetch(`${link}auth/login`, requestOptions)
      .then((response) => {
        return response.json();
      })
      .then((data) => {
        console.log(data);
        const login_status = data["login_status"];
        const login_token = data["login_token"];
        const student_id = data["student_id"];
        const login_Time = data["login_time"];
        const student_Name = data["student_name"];

        if (login_status == "success") {
          const SuccessImage = ({ data }) => (
            <img src={`data:image/jpeg;base64,${data}`} />
          );
          ReactDOM.render(
            <SuccessImage data={data["img"]} />,
            document.getElementById("UserCameraDiv")
          );

          setTimeout(() => {
            setLoginStatus(true);
            setLoginToken(login_token);
            setStudentId(student_id);
            setStudentName(student_Name);
            setLoginTime(login_Time);
          }, 3000);

          // fetch(`https://075b-175-159-176-107.ap.ngrok.io/user/comming_course/${login_token}`)
          //   .then((response) => {
          //     console.log(response)
          //   }).then((data) => {

          //   })
        }
      });
  }, [picture]);

  useEffect(() => {
    // //const requestOptions = {
    //   method: 'GET',
    //   headers: { 'Content-Type': 'application/json' },
    //   };
    const requestOptions = {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: "",
    };
    console.log("Sending get request...");
    console.log(loginToken);
    fetch(`${link}user/coming_course/${loginToken}`, {
      method: "POST",
      //mode: "cors",
      headers: { "Content-Type": "application/json" },
      // headers: {
      //      "Access-Control-Allow-Origin": "*"
      // }
    })
      .then((response) => {
        return response.json();
      })
      .then((data) => {
        //console.log(data["timetable"]["Monday"][0]["stime"]);
        if (data["timetable"] != null) {
          setType(false);

          setTimeTableData((prevTimeTableData) => {
            console.log(data);
            // console.log(data["student_id"]);
            // console.log(data["student_name"]);
            // console.log(data["timetable"]);
            return data;
          });
        } else {
          setType(true);
          setClassData((prevClassData) => {
            console.log(data);
            return data;
          });
          //}
          // setTimeTableData(data);
        }
      });
  }, [loginToken]);
  //axios.post('https://075b-175-159-176-107.ap.ngrok.io/auth/login',JSON.stringify({"base64_encoded_img":picture})).then(res => console.log(res))
  //}, [picture]);
  return (
    <div>
      {loginStatus ? (
        <div>
          {type ? (
            <Information
              studentId={studentId}
              courseId={classData.CourseID}
              courseName={classData.CourseName}
              subClassId={classData.SubclassID}
              description={classData.CourseDescription}
              location={classData.CourseLocation}
              message={classData.TeacherMessage}
              zoomLink={classData.CourseZoomLink}
              start={classData.CourseStartTime}
              end={classData.CourseEndTime}
              events={classData.CourseEvents}
              weekDay={classData.week_day}
              loginToken={loginToken}
              studentName={studentName}
              loginTime={loginTime}
            />
          ) : (
            <Timetable
              id={timeTableData.student_id}
              name={studentName}
              table={timeTableData.timetable}
              loginToken={loginToken}
              loginTime={loginTime}
            />
          )}
        </div>
      ) : (
        <div className={styles.container}>
          {loading ? (
            <div className={styles.loader_container}>
              <div className={styles.spinner}></div>
            </div>
          ) : (
            <div>
              <Nav />

              <div className={styles.login_container}>
                <i class="fa-regular fa-circle-user"></i>
                <h2 className={styles.user_login}>User Login</h2>

                <div id="UserCameraDiv">
                  <Webcam
                    audio={false}
                    height={300}
                    ref={webcamRef}
                    width={300}
                    screenshotFormat="image/jpeg"
                    videoConstraints={videoConstraints}
                    className={styles.video}
                  />
                </div>
                <div class>
                  <button
                    onClick={(e) => {
                      e.preventDefault();
                      capture();
                      e.target.style.display = "none";
                      const txt = document.createElement("h3");
                      txt.innerText = "Detecting Face...";
                      txt.setAttribute("class", "Profile_login_text__-EW2Z");
                      e.target.parentNode.appendChild(txt);
                      //axios.get('http://127.0.0.1:8000/user/comming_course').then(res => console.log(res))
                    }}
                    className={styles.button}
                  >
                    LOG IN
                  </button>
                </div>
              </div>
            </div>
          )}
        </div>
      )}
    </div>
  );
};

export default Profile;
