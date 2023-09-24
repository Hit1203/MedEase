import React, { Component } from 'react'
import Accordion from 'react-bootstrap/Accordion'
import Container from 'react-bootstrap/Container'
import Navbar from 'react-bootstrap/Navbar'
import styles from './Help.module.css'
export default class Help extends Component {
  render() {
    return (
      <>
        <div className={styles.whole}>
          <Navbar className="bg-body-tertiary" bg="dark" data-bs-theme="dark">
            <Container>
              <Navbar.Brand
                href="#home"
                style={{
                  color: 'white',
                  fontSize: '25px',
                  display: 'flex',
                  alignItems: 'center',
                }}
              >
                <img
                  src="/static/frontend/logo.jpg"
                  className={styles.logoimg}
                />{' '}
                MedEase
              </Navbar.Brand>
            </Container>
          </Navbar>
          <div className="mainContent" style={{ padding: '20px' }}>
            <div
              className="title"
              style={{ fontSize: '40px', fontWeight: 'bolder' }}
            >
              Frequently Asked Questions
            </div>
            <div className="faqs">
              <div className="doctors" style={{ marginTop: '20px' }}>
                <div className="subtitle">
                  <h3>For Doctors : </h3>
                  <div className="content">
                    <Accordion defaultActiveKey="0">
                      <Accordion.Item eventKey="0">
                        <Accordion.Header>
                          How to reset a password ?
                        </Accordion.Header>
                        <Accordion.Body>
                          <ol>
                            <li>
                              To reset a password you need to logout of your
                              account, from the drawer on your screen{' '}
                            </li>
                            <li>
                              Then in the next step click on the forgot password
                              and provide your email{' '}
                            </li>
                            <li>
                              Follow the steps sent to your email account.
                            </li>
                          </ol>
                        </Accordion.Body>
                      </Accordion.Item>
                      <Accordion.Item eventKey="1">
                        <Accordion.Header>
                          How to cancel an Appointment ?
                        </Accordion.Header>
                        <Accordion.Body>
                          Lorem ipsum dolor sit amet, consectetur adipiscing
                          elit, sed do eiusmod tempor incididunt ut labore et
                          dolore magna aliqua. Ut enim ad minim veniam, quis
                          nostrud exercitation ullamco laboris nisi ut aliquip
                          ex ea commodo consequat. Duis aute irure dolor in
                          reprehenderit in voluptate velit esse cillum dolore eu
                          fugiat nulla pariatur. Excepteur sint occaecat
                          cupidatat non proident, sunt in culpa qui officia
                          deserunt mollit anim id est laborum.
                        </Accordion.Body>
                      </Accordion.Item>
                    </Accordion>
                  </div>
                </div>
              </div>
              <div className="patients" style={{ marginTop: '20px' }}>
                <div className="subtitle">
                  <h3>For Patients : </h3>
                  <div className="content">
                    <Accordion>
                      <Accordion.Item eventKey="0">
                        <Accordion.Header>
                          How to book an appointment ?
                        </Accordion.Header>
                        <Accordion.Body>
                          Lorem ipsum dolor sit amet, consectetur adipiscing
                          elit, sed do eiusmod tempor incididunt ut labore et
                          dolore magna aliqua. Ut enim ad minim veniam, quis
                          nostrud exercitation ullamco laboris nisi ut aliquip
                          ex ea commodo consequat. Duis aute irure dolor in
                          reprehenderit in voluptate velit esse cillum dolore eu
                          fugiat nulla pariatur. Excepteur sint occaecat
                          cupidatat non proident, sunt in culpa qui officia
                          deserunt mollit anim id est laborum.
                        </Accordion.Body>
                      </Accordion.Item>
                      <Accordion.Item eventKey="1">
                        <Accordion.Header>
                          How to reset password ?
                        </Accordion.Header>
                        <Accordion.Body>
                          Lorem ipsum dolor sit amet, consectetur adipiscing
                          elit, sed do eiusmod tempor incididunt ut labore et
                          dolore magna aliqua. Ut enim ad minim veniam, quis
                          nostrud exercitation ullamco laboris nisi ut aliquip
                          ex ea commodo consequat. Duis aute irure dolor in
                          reprehenderit in voluptate velit esse cillum dolore eu
                          fugiat nulla pariatur. Excepteur sint occaecat
                          cupidatat non proident, sunt in culpa qui officia
                          deserunt mollit anim id est laborum.
                        </Accordion.Body>
                      </Accordion.Item>
                    </Accordion>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <footer
            style={{ position: 'relative', bottom: '0px', padding: '20px' }}
          >
            For any further assistance contact us on :{' '}
            <a>teamsolutionhunters@gmail.com</a>
          </footer>
        </div>
      </>
    )
  }
}
