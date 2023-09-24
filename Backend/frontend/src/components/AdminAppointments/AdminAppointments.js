import React, { Component } from 'react'
import ClipLoader from 'react-spinners/ClipLoader'
import { fetchRequest } from '../../../helpers/fetchRequest'
import styles from './AdminAppointments.module.css'
import Appointments from './Appointments'
// import

const parseCookie = (str) =>
  str
    .split(';')
    .map((v) => v.split('='))
    .reduce((acc, v) => {
      acc[decodeURIComponent(v[0].trim())] = decodeURIComponent(v[1].trim())
      return acc
    }, {})

export default class AdminAppointments extends Component {
  constructor(props) {
    super(props)
    this.state = { appointments: [], isLoading: true, reload: true }
  }

  refresh = () => {
    this.setState({ isLoading: true })
    this.setState({ reload: !this.state.reload })
    fetchRequest({
      path_: '/admin-get-upcoming-appointments/',
      method: 'POST',
      body: {
        jwt: parseCookie(document.cookie).token,
      },
      next: (data) => {
        this.setState({
          appointments: data.responseData.appointments,
          isLoading: false,
        })
      },
    })
  }

  loadAppointment = () => {
    fetchRequest({
      path_: '/admin-get-upcoming-appointments/',
      method: 'POST',
      body: {
        jwt: parseCookie(document.cookie).token,
      },
      next: (data) => {
        this.setState({
          appointments: data.responseData.appointments,
          isLoading: false,
        })
      },
    })
  }

  componentWillMount() {
    this.loadAppointment()
  }

  render() {
    return this.state.isLoading ? (
      <div
        className={styles.coverIt}
        style={{
          justifySelf: 'center',
          alignSelf: 'center',
          marginTop: '30px',
        }}
      >
        <ClipLoader
          color={'blue'}
          loading={true}
          size={100}
          aria-label="Loading Spinner"
          data-testid="loader"
        />
      </div>
    ) : (
      <div className={styles.coverIt}>
        {this.state.appointments.map((appointment, i) => (
          <Appointments
            custom_id={appointment.custom_id}
            doctor_id={appointment.doctor_id}
            doctor_name={appointment.doctor_name}
            // gender={doctor.gender}
            patient_name={appointment.patient_name}
            patient_id={appointment.patient_id}
            time={appointment.time}
            slot={i + 1}
            reload={this.refresh}
            key={i}
          />
        ))}
      </div>
    )
  }
}
