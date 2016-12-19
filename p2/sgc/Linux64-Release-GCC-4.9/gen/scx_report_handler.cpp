/*
 * 
 *
 * This is an automatically generated file. Do not edit.
 *
 * Copyright 2011-2012, 2014 ARM Limited.
 * All rights reserved.
 */

/* Includes */
#include "GlobalDefs.h"

#include <systemc>
#include <cstdio>
#include <cstdlib>
#include <cstdarg>

#include <TxLib/TxLib.h>
#include <scx/scx_ids.h>
#include <scx/scx_report.h>

/* Namespaces */

/*
 * SystemC eXport support namespace.
 */
namespace scx {

/* Globals */

/*
 * Messages identifiers definition.
 *
 * Message identifiers from Fast Models are in the range 1000-1999.
 */
#define DEFINE_MSG(id, n) { \
            (id), \
            0u, {0u},       /* actions */ \
            0u, {0u}, 0u,   /* limits */ \
            0u, {0u}, NULL, /* call counters */ \
            n \
        },

/* Pointer to unique instance of report handler. */
static scx_report_handler_if * default_report_handler_ptr = NULL;

/* Datatypes */

/*
 * Default report handler.
 *
 * NOTE:    This class is final, that is not intended to be derived from.
 */
class scx_report_handler: public scx_report_handler_if {

    /* Construction */
    public:
        scx_report_handler();
        ~scx_report_handler();

    /* Reporting */
    private:
        void set_verbosity_level(int);
        int get_verbosity_level() const;
        void report_info(const char *, const char *, int, const char *, ...);
        void report_info_verb(int, const char *, const char *, int, const char *, ...);
        void report_warning(const char *, const char *, int, const char *, ...);
        void report_error(const char *, const char *, int, const char *, ...);
        void report_fatal(const char *, const char *, int, const char *, ...);

    /* Implementation */
    private:

        /* Datatypes */

        /*
         * Report message datatype for asynchronous reporting.
         */
        struct report_t {
            sc_core::sc_report * m_rep;
            sc_core::sc_actions m_actions;
            report_t():
                m_rep(NULL),
                m_actions(sc_core::SC_STOP) {
            };
            report_t(const sc_core::sc_report & rep,
                     const sc_core::sc_actions & actions):
                m_rep(new sc_core::sc_report(rep)),
                m_actions(actions) {
            };
            void operator()() {
                if (m_actions & (sc_core::SC_STOP
                                 | sc_core::SC_ABORT
                                 | sc_core::SC_THROW)) {
                    scx_report_handler::m_active->done();
                }
                m_actions &= (sc_core::SC_DISPLAY | sc_core::SC_LOG);
                if (m_rep != NULL) {
                    sc_core::sc_report_handler::default_handler((* m_rep), m_actions);
                    delete m_rep;
                    m_rep = NULL;
                }
            };
        };

        /* Member variables */
        int m_verbosity_level;
        static TxActiveObject<report_t> * m_active;

        /* Helpers */
        static void vreport(sc_core::sc_severity,
                            const char *,
                            const char *,
                            int,
                            const char *,
                            std::va_list);

        /* Report handler */
        static void handler(const sc_core::sc_report &,
                            const sc_core::sc_actions &);
};

/* Globals */

/* Active object for synchronous reporting */
TxActiveObject<scx_report_handler::report_t> *
scx_report_handler::m_active = NULL;

/* Functions */

/*
 * Constructs a new report handler.
 */
scx_report_handler::scx_report_handler():
    m_verbosity_level(SCX_MEDIUM) {

    /* Messages identifiers definition */
    static sc_core::sc_msg_def defs[] = {
        DEFINE_MSG(SCX_ID_FM_DEPRECATION,           1000)
        DEFINE_MSG(SCX_ID_INCOMPATIBLE_PTHREADS,    1001)
        DEFINE_MSG(SCX_ID_INITIALIZE_NOT_CALLED,    1002)
        DEFINE_MSG(SCX_ID_INTERNAL_ERROR,           1003)
        DEFINE_MSG(SCX_ID_EVS_EXISTS,               1004)
        DEFINE_MSG(SCX_ID_INVALID_FACTORY,          1005)
        DEFINE_MSG(SCX_ID_LICENSE_ERROR,            1006)
        DEFINE_MSG(SCX_ID_INSTANTIATE_FAILED,       1007)
        DEFINE_MSG(SCX_ID_INSTANCE_NOT_FOUND,       1008)
        DEFINE_MSG(SCX_ID_INVALID_SIMCONTROL,       1009)
        DEFINE_MSG(SCX_ID_GET_REPORT_HANDLER,       1010)
        DEFINE_MSG(SCX_ID_GET_SCHEDULER,            1011)
        DEFINE_MSG(SCX_ID_LOAD_PLUGINS,             1012)
        DEFINE_MSG(SCX_ID_REGISTER_PLUGINS,         1013)
        DEFINE_MSG(SCX_ID_ADD_CALLBACK,             1014)
        DEFINE_MSG(SCX_ID_LOAD_APPLICATION,         1015)
        DEFINE_MSG(SCX_ID_LOAD_DATA,                1016)
        DEFINE_MSG(SCX_ID_PARAM_ERROR,              1017)
    };
    static sc_core::sc_report_handler::msg_def_items msgs = {
        defs, sizeof(defs) / sizeof(defs[0]), false, 0
    };

    /* Message identifiers registration */
    sc_core::sc_report_handler::add_static_msg_types(& msgs);

    /* Process environmental settings... */

    /* 1) Environmental override about deprecation warnings */
    const char * deprecation_warn = std::getenv("FM_SCX_DEPRECATION_WARNINGS");

    if ((deprecation_warn != NULL) && (std::atoi(deprecation_warn) <= 0)) {
        sc_core::sc_report_handler::set_actions(SCX_ID_FM_DEPRECATION,
                                                sc_core::SC_DO_NOTHING);
    }

    /* 2) Setup verbosity level */
    const char * verbosity_level = std::getenv("FM_SCX_VERBOSITY_LEVEL");

    if (verbosity_level != NULL) {
        m_verbosity_level = std::atoi(verbosity_level);
    }

    /* 3) Setup asynchronous report handler procedure */
    if (std::getenv("FM_SCX_ENABLE_ASYNC_REPORT") != NULL) {
        std::size_t queue_size = 4096;
        const char * queue_size_str = std::getenv("FM_SCX_ASYNC_REPORT_MAX_SIZE");

        if (queue_size_str != NULL) {
            queue_size = std::max(1, std::atoi(queue_size_str));
        }
        m_active = TxActiveObject<report_t>::create(queue_size);
        sc_core::sc_report_handler::set_handler(handler);
    }
}

/*
 * Destructs this report handler.
 */
scx_report_handler::~scx_report_handler() {
    default_report_handler_ptr = NULL;

    /* Reset default report handler procedure */
    sc_core::sc_report_handler::set_handler(& sc_core::sc_report_handler::default_handler);
    if (m_active != NULL) {

        /* Stop asynchronous reporting */
        delete m_active;
        m_active = NULL;
    }

    /* If deprecation warnings were issued tell user how to turn them off
     *
     * NOTE:        This does not work when user presses Ctrl-C.  */
    if (sc_core::sc_report_handler::get_count(SCX_ID_FM_DEPRECATION) > 0) {
        SC_REPORT_INFO(SCX_ID_FM_DEPRECATION,
                        "You can turn off warnings about\n"
                        "              Fast Models deprecated features by "
                        "placing this method call\n"
                        "              as the first statement in your "
                        "sc_main() function:\n\n  "
                        "sc_core::sc_report_handler::set_actions("
                        "scx::SCX_ID_FM_DEPRECATION, sc_core::SC_DO_NOTHING);\n");
    }
}

/*!
 * \brief   Sets the verbosity level for information message reports.
 */
void
scx_report_handler::set_verbosity_level(int verbosity) {
    m_verbosity_level = verbosity;
}

/*!
 * \brief   Returns the verbosity level for information message reports.
 */
int
scx_report_handler::get_verbosity_level() const {
    return (m_verbosity_level);
}

/*!
 * \brief   Reports an information message with variable arguments.
 */
void
scx_report_handler::report_info(const char * id,
                                const char * file,
                                int line,
                                const char * fmt,
                                ...) {
    std::va_list arg;

    if (SCX_MEDIUM > m_verbosity_level) {
        return;
    }
    va_start(arg, fmt);
    vreport(sc_core::SC_INFO, id, file, line, fmt, arg);
    va_end(arg);
}

/*!
 * \brief   Reports an information message with variable arguments.
 */
void
scx_report_handler::report_info_verb(int verbosity,
                                     const char * id,
                                     const char * file,
                                     int line,
                                     const char * fmt,
                                     ...) {
    std::va_list arg;

    if (verbosity > m_verbosity_level) {
        return;
    }
    va_start(arg, fmt);
    vreport(sc_core::SC_INFO, id, file, line, fmt, arg);
    va_end(arg);
}

/*!
 * \brief   Reports a warning message with variable arguments.
 */
void
scx_report_handler::report_warning(const char * id,
                                   const char * file,
                                   int line,
                                   const char * fmt,
                                   ...) {
    std::va_list arg;

    va_start(arg, fmt);
    vreport(sc_core::SC_WARNING, id, file, line, fmt, arg);
    va_end(arg);
}

/*!
 * \brief   Reports an error message with variable arguments.
 */
void
scx_report_handler::report_error(const char * id,
                                 const char * file,
                                 int line,
                                 const char * fmt,
                                 ...) {
    std::va_list arg;

    va_start(arg, fmt);
    vreport(sc_core::SC_ERROR, id, file, line, fmt, arg);
    va_end(arg);
}

/*!
 * \brief   Reports a fatal error message with variable arguments.
 */
void
scx_report_handler::report_fatal(const char * id,
                                 const char * file,
                                 int line,
                                 const char * fmt,
                                 ...) {
    std::va_list arg;

    va_start(arg, fmt);
    vreport(sc_core::SC_FATAL, id, file, line, fmt, arg);
    va_end(arg);
}

/*
 * Reports a message with variable arguments like the printf() function.
 */
void
scx_report_handler::vreport(sc_core::sc_severity severity,
                            const char * id,
                            const char * file,
                            int line,
                            const char * fmt,
                            std::va_list arg) {
    char msg[1024] = "";

    if ((fmt != NULL) && ((* fmt) != '\0')) {
        ::vsnprintf(msg, sizeof(msg), fmt, arg);
    }
    sc_core::sc_report_handler::report(severity,
                                       id,
                                       msg,
                                       (file == NULL? "(none)": file),
                                       line);
}

/*
 * Handler of message reporting.
 */
void
scx_report_handler::handler(const sc_core::sc_report & rep,
                            const sc_core::sc_actions & actions) {
    const sc_core::sc_actions async_actions = sc_core::SC_DISPLAY | sc_core::SC_LOG;

    /* Handle report asynchronously */
    m_active->push(report_t(rep, actions));
    if (actions & ~async_actions) {

        /* Handle report synchronously */
        sc_core::sc_report_handler::default_handler(rep, actions & ~async_actions);
    }
}

/*!
 * \brief   Returns a pointer to the default implementation of the report
 *          handler provided with Fast Models.
 */
scx_report_handler_if * scx_get_default_report_handler() {
    if (default_report_handler_ptr == NULL) {
        static scx_report_handler default_report_handler;

        default_report_handler_ptr = & default_report_handler;
    }
    return (default_report_handler_ptr);
}

}   /* namespace scx */
