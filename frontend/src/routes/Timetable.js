import React, { useState, useEffect } from "react";
import styles from "./Timetable.module.css";
import PropTypes from "prop-types";
import { Link } from "react-router-dom";
import time from "./Timetable.css";
import Nav from "../components/NavSuccess";

function Timetable({ id, name, table, loginToken, loginTime }) {
  console.log(id);
  console.log(name);
  //console.log(table.Tuesday);
  function strToMins(t) {
    var s = t.split(":");
    return Number(s[0]) * 60 + Number(s[1]);
  }

  function minsToStr(t) {
    return Math.trunc(t / 60) + ":" + ("00" + (t % 60)).slice(-2);
  }

  useEffect(() => {
    for (let i = 0; i < table.Monday.length; i++) {
      let id = table.Monday[i].course_id;
      let name = table.Monday[i].course_name;
      let start = table.Monday[i].stime;
      let end = table.Monday[i].etime;
      let subClassId = table.Monday[i].subclass_id;

      let identifier = `Monday${start}`;

      var result = minsToStr(strToMins(end) - strToMins(start));
      console.log(result);
      let container = document.getElementById(`${identifier}`);

      container.innerText = `${id}${subClassId}`;
      container.setAttribute("class", `${id}`);

      if (result == "1:50") {
        var time = minsToStr(strToMins(start) + strToMins("1:00"));

        identifier = `Monday${time}`;

        container = document.getElementById(`${identifier}`);

        container.setAttribute("class", `${id}`);
      } else if (result == "2:50") {
        var time1 = minsToStr(strToMins(start) + strToMins("1:00"));
        var time2 = minsToStr(strToMins(start) + strToMins("2:00"));

        var identifier1 = `Monday${time1}`;
        var identifier2 = `Monday${time2}`;

        var container1 = document.getElementById(`${identifier1}`);
        var container2 = document.getElementById(`${identifier2}`);

        container1.setAttribute("class", `${id}`);
        container2.setAttribute("class", `${id}`);
      }
    }

    for (let i = 0; i < table.Tuesday.length; i++) {
      let id = table.Tuesday[i].course_id;
      let name = table.Tuesday[i].course_name;
      let start = table.Tuesday[i].stime;
      let end = table.Tuesday[i].etime;
      let subClassId = table.Tuesday[i].subclass_id;

      let identifier = `Tuesday${start}`;

      var result = minsToStr(strToMins(end) - strToMins(start));
      console.log(result);
      let container = document.getElementById(`${identifier}`);

      container.innerText = `${id}${subClassId}`;
      container.setAttribute("class", `${id}`);

      if (result == "1:50") {
        var time = minsToStr(strToMins(start) + strToMins("1:00"));

        identifier = `Tuesday${time}`;

        container = document.getElementById(`${identifier}`);

        container.setAttribute("class", `${id}`);
      } else if (result == "2:50") {
        var time1 = minsToStr(strToMins(start) + strToMins("1:00"));
        var time2 = minsToStr(strToMins(start) + strToMins("2:00"));

        var identifier1 = `Tuesday${time1}`;
        var identifier2 = `Tuesday${time2}`;

        var container1 = document.getElementById(`${identifier1}`);
        var container2 = document.getElementById(`${identifier2}`);

        container1.setAttribute("class", `${id}`);
        container2.setAttribute("class", `${id}`);
      }
    }

    for (let i = 0; i < table.Wednesday.length; i++) {
      let id = table.Wednesday[i].course_id;
      let name = table.Wednesday[i].course_name;
      let start = table.Wednesday[i].stime;
      let end = table.Wednesday[i].etime;
      let subClassId = table.Wednesday[i].subclass_id;

      let identifier = `Wednesday${start}`;

      var result = minsToStr(strToMins(end) - strToMins(start));
      console.log(result);
      let container = document.getElementById(`${identifier}`);

      container.innerText = `${id}${subClassId}`;
      container.setAttribute("class", `${id}`);

      if (result == "1:50") {
        var time = minsToStr(strToMins(start) + strToMins("1:00"));

        identifier = `Wednesday${time}`;

        container = document.getElementById(`${identifier}`);

        container.setAttribute("class", `${id}`);
      } else if (result == "2:50") {
        var time1 = minsToStr(strToMins(start) + strToMins("1:00"));
        var time2 = minsToStr(strToMins(start) + strToMins("2:00"));

        var identifier1 = `Wednesday${time1}`;
        var identifier2 = `Wednesday${time2}`;

        var container1 = document.getElementById(`${identifier1}`);
        var container2 = document.getElementById(`${identifier2}`);

        container1.setAttribute("class", `${id}`);
        container2.setAttribute("class", `${id}`);
      }
    }

    for (let i = 0; i < table.Thursday.length; i++) {
      let id = table.Thursday[i].course_id;
      let name = table.Thursday[i].course_name;
      let start = table.Thursday[i].stime;
      let end = table.Thursday[i].etime;
      let subClassId = table.Thursday[i].subclass_id;

      let identifier = `Thursday${start}`;

      var result = minsToStr(strToMins(end) - strToMins(start));
      console.log(result);
      let container = document.getElementById(`${identifier}`);

      container.innerText = `${id}${subClassId}`;
      container.setAttribute("class", `${id}`);

      if (result == "1:50") {
        var time = minsToStr(strToMins(start) + strToMins("1:00"));

        identifier = `Thursday${time}`;

        container = document.getElementById(`${identifier}`);

        container.setAttribute("class", `${id}`);
      } else if (result == "2:50") {
        var time1 = minsToStr(strToMins(start) + strToMins("1:00"));
        var time2 = minsToStr(strToMins(start) + strToMins("2:00"));

        var identifier1 = `Thursday${time1}`;
        var identifier2 = `Thursday${time2}`;

        var container1 = document.getElementById(`${identifier1}`);
        var container2 = document.getElementById(`${identifier2}`);

        container1.setAttribute("class", `${id}`);
        container2.setAttribute("class", `${id}`);
      }
    }

    for (let i = 0; i < table.Friday.length; i++) {
      let id = table.Friday[i].course_id;
      let name = table.Friday[i].course_name;
      let start = table.Friday[i].stime;
      let end = table.Friday[i].etime;
      let subClassId = table.Friday[i].subclass_id;

      let identifier = `Friday${start}`;

      var result = minsToStr(strToMins(end) - strToMins(start));
      console.log(result);
      let container = document.getElementById(`${identifier}`);

      container.innerText = `${id}${subClassId}`;
      container.setAttribute("class", `${id}`);

      if (result == "1:50") {
        var time = minsToStr(strToMins(start) + strToMins("1:00"));

        identifier = `Friday${time}`;

        container = document.getElementById(`${identifier}`);

        container.setAttribute("class", `${id}`);
      } else if (result == "2:50") {
        var time1 = minsToStr(strToMins(start) + strToMins("1:00"));
        var time2 = minsToStr(strToMins(start) + strToMins("2:00"));

        var identifier1 = `Friday${time1}`;
        var identifier2 = `Friday${time2}`;

        var container1 = document.getElementById(`${identifier1}`);
        var container2 = document.getElementById(`${identifier2}`);

        container1.setAttribute("class", `${id}`);
        container2.setAttribute("class", `${id}`);
      }
    }
    //console.log(table.Friday.length);
    //table.slice(0.2).map((g) => console.log(g));
  });

  return (
    <div>
      <Nav loginToken={loginToken} studentName={name} loginTime={loginTime} />
      <table cellSpacing="0" className={styles.container}>
        <thead>
          <tr class="">
            <th class="">
              {name}
              <br></br>
              {id}
            </th>
            <th class="">Monday</th>
            <th class="">Tuesday</th>
            <th class="">Wednesday</th>
            <th class="">Thursday</th>
            <th class="">Friday</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td id="align-middle">09:30am - 10:30am</td>
            <td id="Monday09:30"></td>
            <td id="Tuesday09:30"></td>
            <td id="Wednesday09:30"></td>
            <td id="Thursday09:30"></td>
            <td id="Friday09:30"></td>
          </tr>
          <tr>
            <td id="align-middle">10:30am - 11:30am</td>
            <td id="Monday10:30"></td>
            <td id="Tuesday10:30"></td>
            <td id="Wednesday10:30"></td>
            <td id="Thursday10:30"></td>
            <td id="Friday10:30"></td>
          </tr>
          <tr>
            <td id="align-middle">11:30am - 12:30pm</td>
            <td id="Monday11:30"></td>
            <td id="Tuesday11:30"></td>
            <td id="Wednesday11:30"></td>
            <td id="Thursday11:30"></td>
            <td id="Friday11:30"></td>
          </tr>
          <tr>
            <td id="align-middle">12:30pm - 13:30pm</td>
            <td id="Monday12:30"></td>
            <td id="Tuesday12:30"></td>
            <td id="Wednesday12:30"></td>
            <td id="Thursday12:30"></td>
            <td id="Friday12:30"></td>
          </tr>
          <tr>
            <td id="align-middle">13:30pm - 14:30pm</td>
            <td id="Monday13:30"></td>
            <td id="Tuesday13:30"></td>
            <td id="Wednesday13:30"></td>
            <td id="Thursday13:30"></td>
            <td id="Friday13:30"></td>
          </tr>
          <tr>
            <td id="align-middle">14:30pm - 15:30pm</td>
            <td id="Monday14:30"></td>
            <td id="Tuesday14:30"></td>
            <td id="Wednesday14:30"></td>
            <td id="Thursday14:30"></td>
            <td id="Friday14:30"></td>
          </tr>
          <tr>
            <td id="align-middle">15:30pm - 16:30pm</td>
            <td id="Monday15:30"></td>
            <td id="Tuesday15:30"></td>
            <td id="Wednesday15:30"></td>
            <td id="Thursday15:30"></td>
            <td id="Friday15:30"></td>
          </tr>
          <tr>
            <td id="align-middle">16:30pm - 17:30pm</td>
            <td id="Monday16:30"></td>
            <td id="Tuesday16:30"></td>
            <td id="Wednesday16:30"></td>
            <td id="Thursday16:30"></td>
            <td id="Friday16:30"></td>
          </tr>
          <tr>
            <td id="align-middle">17:30pm - 18:30pm</td>
            <td id="Monday17:30"></td>
            <td id="Tuesday17:30"></td>
            <td id="Wednesday17:30"></td>
            <td id="Thursday17:30"></td>
            <td id="Friday17:30"></td>
          </tr>
        </tbody>
      </table>
    </div>
  );
}

Timetable.propTypes = {
  id: PropTypes.string.isRequired,
  name: PropTypes.string.isRequired,
  table: PropTypes.arrayOf(PropTypes.any).isRequired,
  loginToken: PropTypes.string.isRequired,
  loginTime: PropTypes.string.isRequired,
};

export default Timetable;
