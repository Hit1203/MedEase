import React, { Component } from 'react'
import ClipLoader from 'react-spinners/ClipLoader'
import { fetchRequest } from '../../../helpers/fetchRequest'
import styles from './AdminPanelLogin.module.css'

const parseCookie = (str) =>
  str
    .split(';')
    .map((v) => v.split('='))
    .reduce((acc, v) => {
      acc[decodeURIComponent(v[0].trim())] = decodeURIComponent(v[1].trim())
      return acc
    }, {})

export default class AdminPanelLogin extends Component {
  constructor(props) {
    super(props)
    this.state = { email: '', password: '', isCorrect: true, isLoading: false }
    this.handlePasswordChange = this.onPasswordChange.bind(this)
    this.handleEmailChange = this.onEmailChange.bind(this)
    this.handleSubmit = this.onSubmit.bind(this)
  }

  onPasswordChange(event) {
    this.setState({
      password: event.target.value,
    })
  }

  onEmailChange(event) {
    this.setState({
      email: event.target.value,
    })
  }

  onSubmit(event) {
    if (this.state.isCorrect && !this.state.isLoading) {
      this.setState({ isLoading: true })
      fetchRequest({
        path_: '/admin-panel/login/',
        method: 'POST',
        body: {
          email: this.state.email,
          password: this.state.password,
        },
        next: (data) => {
          if (data['responseData']['isAuthenticated']) {
            window.location.pathname = '/admin-panel/'
          } else {
            // REDIRECT TO A ERROR PAGE
            alert('Invalid Creds')
          }
          this.setState({ isLoading: false })
        },
      })
    }
  }

  render() {
    return (
      <div className={styles.whole}>
        <div className={styles.menu}>
          <div className={styles.logo}>
            <img src="/static/frontend/logo.jpg" className={styles.logoimg} />
          </div>
          <div className={styles.name}>
            <h3>MedEase</h3>
            <h6>Admin Panel Access</h6>
          </div>
          <div className={styles.main}>
            <div className={styles.inputs}>
              <input
                type="email"
                id="email"
                placeholder="Email"
                onChange={this.handleEmailChange}
                value={this.state.email}
              />
              <input
                type="password"
                id="Password"
                placeholder="Password"
                onChange={this.handlePasswordChange}
                value={this.state.password}
                style={{ marginBottom: '0px', marginTop: '30px' }}
              />
            </div>
            <div className={styles.submit}>
              {this.state.isLoading ? (
                <div className={styles.coverIt}>
                  <ClipLoader
                    color={'white'}
                    loading={true}
                    size={30}
                    aria-label="Loading Spinner"
                    data-testid="loader"
                  />
                </div>
              ) : (
                <div
                  className={styles.button}
                  onClick={this.handleSubmit}
                  style={{
                    background: this.state.passwordMatch ? 'white' : 'gray',
                    color: this.state.passwordMatch ? 'black' : 'white',
                  }}
                >
                  Submit
                </div>
              )}
            </div>
            <div className={styles.container}></div>
          </div>
        </div>
      </div>
    )
  }
}
