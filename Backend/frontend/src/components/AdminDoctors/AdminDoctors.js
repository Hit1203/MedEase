import React, { Component } from 'react'
import ClipLoader from 'react-spinners/ClipLoader'
import { fetchRequest } from '../../../helpers/fetchRequest'
import styles from './AdminDoctors.module.css'
import Doctor from './Doctor'

export default class AdminDoctors extends Component {
  constructor(props) {
    super(props)
    this.state = { doctors: [], reload: true, isLoading: true }
  }

  refresh = () => {

    this.setState({ reload: !this.state.reload })
    fetchRequest({
      path_: '/api/get-doctors/',
      method: 'POST',
      body: {},
      next: (data) => {
        this.setState({ doctors: data.responseData.doctors, isLoading: false })
      },
    })
  }

  componentWillMount() {
    fetchRequest({
      path_: '/api/get-doctors/',
      method: 'POST',
      body: {},
      next: (data) => {
        this.setState({ doctors: data.responseData.doctors, isLoading: false })
      },
    })
  }
  render() {
    return !this.state.isLoading ? (
      <div className={styles.coverIt}>
        {this.state.doctors.map((doctor, i) => (
          <Doctor
            fullname={doctor.fullname}
            custom_id={doctor.custom_id}
            med_id={doctor.medical_id}
            gender={doctor.gender}
            wh_start={doctor.wh_start}
            wh_end={doctor.wh_end}
            holidays={doctor.holiday_days}
            reload={this.refresh}
            key={i}
          />
        ))}
      </div>
    ) : (
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
    )
  }
}
