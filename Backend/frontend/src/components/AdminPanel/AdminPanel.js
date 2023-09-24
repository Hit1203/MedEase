import React, { Component } from 'react'
import Container from 'react-bootstrap/Container'
import Navbar from 'react-bootstrap/Navbar'
import Tab from 'react-bootstrap/Tab'
import Tabs from 'react-bootstrap/Tabs'
import AdminAppointments from '../AdminAppointments/AdminAppointments'
import AdminDoctors from '../AdminDoctors/AdminDoctors'
import AdminPatients from '../AdminPatients/AdminPatients'
import styles from './AdminPanel.module.css'
import './styles.css'

export default class AdminPanel extends Component {
  constructor(props) {
    super(props)
    this.state = { doctors: [], patients: [], appointments: [] }
  }
  render() {
    return (
      <>
        <div className={styles.whole}>
          <Navbar
            className={`bg-body-tertiary ${styles.navbar}`}
            bg="dark"
            data-bs-theme="dark"
          >
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
              <div
                className="logout"
                style={{
                  color: 'wheat',
                  marginRight: '10px',
                  cursor: 'pointer',
                }}
                onClick={(event) => {
                  event.preventDefault()
                  document.cookie = ''
                  window.location.pathname = '/admin-panel/login/'
                }}
              >
                LOG OUT
              </div>
            </Container>
          </Navbar>
          <Tabs
            defaultActiveKey="Doctors"
            id="uncontrolled-tab-example"
            className={`mb-2 ${styles.tabs}`}
          >
            <Tab eventKey="Doctors" title="Doctors" className={styles.tab}>
              <AdminDoctors />
            </Tab>
            <Tab eventKey="Patients" title="Patients" className={styles.tab}>
              <AdminPatients />
            </Tab>
            <Tab
              eventKey="Appointments"
              title="Appointments"
              className={styles.tab}
            >
              <AdminAppointments />
            </Tab>
          </Tabs>
        </div>
      </>
    )
  }
}
