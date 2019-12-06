
class BootStrap {

    def init = { servletContext ->
          TimeZone.setDefault(TimeZone.getTimeZone("America/Bogota"));
    }
    def destroy = {
    }
}
