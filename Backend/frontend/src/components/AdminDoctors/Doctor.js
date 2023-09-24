import { faTrash } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import React, { Component } from 'react'
import { fetchRequest } from '../../../helpers/fetchRequest'
import styles from './Doctor.module.css'

const parseCookie = (str) =>
  str
    .split(';')
    .map((v) => v.split('='))
    .reduce((acc, v) => {
      acc[decodeURIComponent(v[0].trim())] = decodeURIComponent(v[1].trim())
      return acc
    }, {})

export default class Doctor extends Component {
  constructor(props) {
    super(props)
    this.state = {}
    this.handleDelete = this.delete__.bind(this)
  }

  delete__(event) {
    //EZBUHEKWESKBIDJJDERC
    fetchRequest({
      path_: '/delete-user/',
      method: 'POST',
      body: {
        jwt: parseCookie(document.cookie).token,
        custom_id: this.props.custom_id,
      },
      next: (data) => {
        if (
          data['responseData']['authorized'] &&
          data['responseData']['deleted']
        ) {
          this.props.reload()
        }
      },
    })
  }

  render() {
    return (
      <div className={styles.container}>
        <div className={styles.logo}>
          <img
            className={styles.logoimg}
            src={
              this.props.gender == 'Male'
                ? '/static/frontend/maleDOC.jpg'
                : '/static/frontend/femaleDOC.jpg'
            }
          />
        </div>
        <div className={styles.midPanel}>
          <div className={styles.top}>
            <p style={{ margin: '0px' }}>Dr. {this.props.fullname}</p>{' '}
            <p style={{ margin: '0px' }}>{this.props.med_id}</p>
          </div>
          <div className={styles.bottom}>
            <p style={{ margin: '0px', fontSize: '10px' }}>
              {this.props.wh_start}-{this.props.wh_end}
            </p>{' '}
            <p style={{ margin: '0px', fontSize: '10px' }}>
              {this.props.holidays}
            </p>
          </div>
        </div>
        <div className={styles.delContainer}>
          <FontAwesomeIcon
            icon={faTrash}
            onClick={this.handleDelete}
            className={styles.hover}
          />
        </div>
      </div>
    )
  }
}
