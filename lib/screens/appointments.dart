import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_of_peace/models/appointment.dart';
import 'package:queen_of_peace/providers/appointment_provider.dart';
import 'package:queen_of_peace/widgets/add_appointment.dart';
import 'package:queen_of_peace/widgets/edit_appointment.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppointmentProvider>(context);
    List<Appointment> appointments = provider.appointments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
      ),
      body: ListView.builder(
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            Appointment appointment = appointments[index];

            return ListTile(
              title: Text(appointment.patientName),
              subtitle: Text(appointment.appointmentDate),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Temp ${appointment.temperature}"),
                      Text("BP ${appointment.bpReading}"),
                      Text("Sugar Level ${appointment.sugarLevel}"),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return EditAppointment(
                                  provider.updateAppointment, appointment);
                            });
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(onPressed: null, icon: const Icon(Icons.delete))
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(CupertinoIcons.add),
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return AddAppointment(provider.addAppointment);
                });
          }),
    );
  }
}
