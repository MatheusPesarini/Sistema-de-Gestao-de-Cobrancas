package backend

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder

@EqualsAndHashCode(includes = 'username')
@ToString(includes = 'username', includeNames = true, includePackage = false)
class User implements Serializable {

    private static final long serialVersionUID = 1

    private static final BCryptPasswordEncoder ENCODER = new BCryptPasswordEncoder()

    String username
    String password
    boolean enabled = true
    boolean accountExpired = false
    boolean accountLocked = false
    boolean passwordExpired = false

    Set<Role> getAuthorities() {
        (UserRole.findAllByUser(this) as List<UserRole>)*.role as Set<Role>
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = '{bcrypt}' + ENCODER.encode(password)
    }

    static constraints = {
        username blank: false, unique: true, size: 1..255
        password blank: false, size: 1..500
    }

    static mapping = {
        password column: '`password`'
        table '`user`'
    }
}




