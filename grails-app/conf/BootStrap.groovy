import com.drawingboard.Role
import com.drawingboard.User
import com.drawingboard.UserRole

class BootStrap {

    def springSecurityService

    def init = { servletContext ->

        def adminRole = Role.findByAuthority('ROLE_ADMIN')
        def userRole = Role.findByAuthority('ROLE_USER')

        if (!adminRole) {
            adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
        }
        if (!userRole) {
            userRole = new Role(authority: 'ROLE_USER').save(flush: true)
        }
        if (!User.findByUsername('meadmin')) {
            def testUser = new User(username: 'meadmin', enabled: true, password: springSecurityService.encodePassword('password'),
                    accountExpired: false, accountLocked: false, passwordExpired: false, companyName: 'Yukti')

            testUser.save(flush: true)
            UserRole.create testUser, adminRole, true
        }
//        if (!User.findByUsername('meuser')) {
//            def testUser = new User(username: 'meuser', enabled: true, password: 'password')
//            testUser.save(flush: true)
//            UserRole.create testUser, userRole, true
//        }

//        assert User.count() == 2
//        assert Role.count() == 2
//        assert UserRole.count() == 2

    }
    def destroy = {
    }
}
