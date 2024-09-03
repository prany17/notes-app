import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_practice/models/note.dart';
import 'package:todo_practice/models/note_database.dart';
import 'package:todo_practice/pages/settings_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text editing controllers
  final addController = TextEditingController();
  final updateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // on app startup fetch the notes
    fetchNotes();
  }

  // add note
  void addNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'Add a Note',
            style: GoogleFonts.aBeeZee(fontSize: 20),
          ),
        ),
        content: TextField(
          cursorColor: Theme.of(context).colorScheme.inversePrimary,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          controller: addController,
        ),
        actions: [
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.blueGrey[300],
            onPressed: () {
              // add the note to db
              context.read<NoteDatabase>().addNote(addController.text);

              // clear the controller
              addController.clear();

              // pop the dialog box
              Navigator.pop(context);
            },
            child: Text(
              'Add ',
              style: GoogleFonts.aBeeZee(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // read note
  void fetchNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  // update note
  void updateNote(Note note) {
    // put the already existing text of the note in controller
    updateController.text = note.taskName.toString();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'Update a Note',
            style: GoogleFonts.aBeeZee(fontSize: 20),
          ),
        ),
        content: TextField(
          cursorColor: Theme.of(context).colorScheme.inversePrimary,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          controller: updateController,
        ),
        actions: [
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.blueGrey[300],
            onPressed: () {
              // add the note to db
              context
                  .read<NoteDatabase>()
                  .updateNotes(updateController.text, note.id);

              // clear the controller
              updateController.clear();

              // pop the dialog box
              Navigator.pop(context);
            },
            child: Text(
              'Update ',
              style: GoogleFonts.aBeeZee(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // delete note
  void deleteNote(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'Are you sure? you want to delete.',
            style: GoogleFonts.aBeeZee(fontSize: 20),
          ),
        ),
        actions: [
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.blueGrey[300],
            onPressed: () {
              // delete the note from db
              context.read<NoteDatabase>().deleteNotes(id);

              // pop the dialog box
              Navigator.pop(context);
            },
            child: Text(
              'Delete ',
              style: GoogleFonts.aBeeZee(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // note database
    final notedatabase = context.watch<NoteDatabase>();

    // get list of notes from db
    List<Note> currentNotes = notedatabase.currentNotes;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              ),
              icon: const Icon(Icons.settings),
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          onPressed: () => addNote(),
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // logo icon
            const DrawerHeader(
              margin: EdgeInsets.only(top: 70),
              child: Icon(
                size: 70,
                Icons.library_books,
              ),
            ),

            const SizedBox(height: 30),

            // list tile ui
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: GestureDetector(
                onTap: () {
                  // pop the drawer
                  Navigator.pop(context);
                },
                // tasks tile
                child: ListTile(
                  leading: const Icon(Icons.library_books),
                  title: Text(
                    'Notes',
                    style: GoogleFonts.aBeeZee(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: GestureDetector(
                onTap: () {
                  // navigate to settings page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ),
                  );
                },
                // settings tile
                child: ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(
                    'Settings',
                    style: GoogleFonts.aBeeZee(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 25),
            child: Text(
              'Notes',
              style: GoogleFonts.aBeeZee(
                fontSize: 48,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          const SizedBox(height: 25),

          // list tile of notes
          Expanded(
            child: ListView.builder(
              // get each individual note from db
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                final note = currentNotes[index];
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 15),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const StretchMotion(),
                      extentRatio: 0.3,
                      children: [
                        SlidableAction(
                          backgroundColor: Colors.red.shade400,
                          borderRadius: BorderRadius.circular(15),
                          onPressed: (context) => deleteNote(note.id),
                          icon: Icons.delete,
                        )
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: note.isChecked!
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.primary,
                      ),
                      child: ListTile(
                        leading: Checkbox(
                          activeColor:
                              Theme.of(context).colorScheme.inversePrimary,
                          value: currentNotes[index].isChecked,
                          onChanged: (value) {
                            setState(() {
                              currentNotes[index].isChecked = value!;
                            });
                          },
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, top: 20, bottom: 15),
                          child: Text(
                            note.taskName.toString(),
                            style: TextStyle(
                              decoration: note.isChecked!
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => updateNote(note),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
