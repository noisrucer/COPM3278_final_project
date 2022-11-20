import nav from "./Nav.module.css";
import { Link } from "react-router-dom";
import PropTypes from "prop-types";
const link = "http://localhost:8000/";

function NavSuccess({ loginToken, studentName, loginTime }) {
  return (
    <div className={nav.box}>
      <div className={nav.column}>
        <div className={nav.home}>
          <img
            className={nav.img}
            src="http://www2.facdent.hku.hk/images/faclogoonly.png"
          ></img>
          <h3 className={nav.hku}>H K U x I C M S</h3>
          <h6 className={nav.welcome}>Welcome {studentName}! </h6>
          <h6 className={nav.welcome}> Login Time: {loginTime}</h6>
        </div>
      </div>
      <div>
        <div className={nav.column}>
          <Link to={`/`}>
            <button
              className={nav.button}
              onClick={(e) => {
                e.preventDefault();
                console.log(loginToken);
                const requestOptions = {
                  method: "POST",
                  headers: { "Content-Type": "application/json" },
                  body: JSON.stringify({
                    login_token: loginToken,
                  }),
                };
                fetch(`${link}auth/logout`, requestOptions)
                  .then((response) => {
                    return response.json();
                  })
                  .then((data) => {
                    console.log(data);
                  });
              }}
            >
              Log Out
            </button>
          </Link>
        </div>
      </div>
    </div>
  );
}

NavSuccess.propTypes = {
  loginToken: PropTypes.string.isRequired,
  studentName: PropTypes.string.isRequired,
  loginTime: PropTypes.string.isRequired,
};

export default NavSuccess;
