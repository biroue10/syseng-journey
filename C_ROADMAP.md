# C Programming Roadmap — Linux Systems Engineer Path

> Objectif : maîtriser C pour devenir Systems Engineer → SRE/Platform Engineer → Linux Kernel Developer

**Durée estimée :** 12-18 mois (en parallèle avec les autres projets)
**Référence principale :** *The Linux Programming Interface* — Michael Kerrisk

---

## Progression

| Phase | Titre | Durée | Statut |
|-------|-------|-------|--------|
| Phase 1 | C Fundamentals | 4-6 semaines | ⬜ |
| Phase 2 | C Système Linux | 6-8 semaines | ⬜ |
| Phase 3 | C Réseau | 4-6 semaines | ⬜ |
| Phase 4 | Structures de données & Algorithmes | 4-6 semaines | ⬜ |
| Phase 5 | Linux Kernel | 8-12 semaines | ⬜ |

---

## Phase 1 — C Fundamentals

> Écrire des programmes C qui compilent et fonctionnent correctement.

### C-01 — Variables, types, conditions, boucles ⬜

Concepts :
- Types de base : `int`, `char`, `float`, `double`, `long`
- Opérateurs arithmétiques et logiques
- `if`, `else`, `switch`
- `for`, `while`, `do-while`

Projet : calculatrice en ligne de commande

---

### C-02 — Fonctions et récursion ⬜

Concepts :
- Déclaration et définition de fonctions
- Passage par valeur
- Récursion (factorielle, Fibonacci)
- Header files `.h`

Projet : bibliothèque de fonctions mathématiques

---

### C-03 — Tableaux, strings, I/O ⬜

Concepts :
- Tableaux statiques et multidimensionnels
- Strings : `strlen`, `strcpy`, `strcmp`, `strcat`
- `printf` / `scanf` / `fgets`

Projet : programme de manipulation de strings

---

### C-04 — Pointeurs ⬜

> Le concept le plus important de C — indispensable pour le système.

Concepts :
- Déclaration et déréférencement (`*`, `&`)
- Arithmétique des pointeurs
- Pointeurs et tableaux
- Pointeurs de fonctions
- `NULL` et dangling pointers

Projet : implémentation de `strlen` et `strcpy` from scratch

---

### C-05 — Allocation mémoire dynamique ⬜

Concepts :
- Stack vs Heap
- `malloc`, `calloc`, `realloc`, `free`
- Memory leaks et segfaults
- `valgrind` pour détecter les fuites

```bash
# Compiler avec debug
gcc -g -Wall -Wextra -o programme programme.c

# Vérifier les fuites mémoire
valgrind --leak-check=full ./programme
```

Projet : tableau dynamique (vector) en C

---

## Phase 2 — C Système Linux

> Interagir avec le noyau Linux via les appels système.

### C-06 — File I/O bas niveau ⬜

Concepts :
- Syscalls : `open`, `read`, `write`, `close`
- Flags : `O_RDONLY`, `O_WRONLY`, `O_CREAT`, `O_APPEND`
- File descriptors
- `lseek`, `stat`, `fstat`

```c
int fd = open("fichier.txt", O_WRONLY | O_CREAT, 0644);
write(fd, "hello\n", 6);
close(fd);
```

Projet : programme `cp` (copie de fichier) from scratch

---

### C-07 — Processus : fork, exec, wait ⬜

Concepts :
- `fork()` — dupliquer un processus
- `exec()` — remplacer un processus
- `wait()` / `waitpid()` — attendre un fils
- Processus zombie et orphelin

```c
pid_t pid = fork();
if (pid == 0) {
    execl("/bin/ls", "ls", "-la", NULL);
} else {
    wait(NULL);
}
```

Projet : mini shell en C (exécuter des commandes)

---

### C-08 — Signaux ⬜

Concepts :
- `signal()` / `sigaction()`
- Signaux courants : `SIGTERM`, `SIGKILL`, `SIGCHLD`, `SIGUSR1`
- `kill()`, `raise()`
- Signal handlers

Projet : daemon C qui répond aux signaux (reload config sur SIGHUP)

---

### C-09 — Pipes et IPC ⬜

Concepts :
- `pipe()` — communication entre processus
- `dup2()` — redirection des file descriptors
- Named pipes (FIFO)
- Shared memory : `shmget`, `shmat`

Projet : implémenter `ls | wc -l` en C (pipeline de processus)

---

### C-10 — Threads POSIX ⬜

Concepts :
- `pthread_create`, `pthread_join`, `pthread_exit`
- Race conditions
- `pthread_mutex_lock` / `pthread_mutex_unlock`
- Sémaphores : `sem_wait`, `sem_post`

```bash
gcc -o programme programme.c -lpthread
```

Projet : serveur multi-threadé en C

---

## Phase 3 — C Réseau

> Écrire des clients et serveurs — indispensable pour SRE.

### C-11 — Sockets TCP ⬜

Concepts :
- `socket`, `bind`, `listen`, `accept`, `connect`
- `send`, `recv`
- Adresses : `sockaddr_in`, `inet_pton`

```c
int sockfd = socket(AF_INET, SOCK_STREAM, 0);
bind(sockfd, (struct sockaddr*)&addr, sizeof(addr));
listen(sockfd, 5);
int client = accept(sockfd, NULL, NULL);
```

Projet : serveur echo TCP en C

---

### C-12 — Client HTTP en C ⬜

Concepts :
- Requête HTTP/1.1 manuellement
- Parser les headers HTTP
- `getaddrinfo` pour la résolution DNS

Projet : `curl` minimaliste en C (GET HTTP)

---

### C-13 — Serveur HTTP minimal ⬜

Concepts :
- Parser les requêtes HTTP
- Servir des fichiers statiques
- Gérer plusieurs connexions

Projet : serveur HTTP qui sert des fichiers HTML

---

### C-14 — I/O non-bloquant : select / epoll ⬜

Concepts :
- `select()` — surveiller plusieurs fd simultanément
- `epoll_create`, `epoll_ctl`, `epoll_wait`
- Event-driven programming

Projet : serveur TCP qui gère 1000+ connexions simultanées

---

## Phase 4 — Structures de données & Algorithmes

> Indispensable pour les interviews Systems/SRE Engineer.

### C-15 — Linked list, Stack, Queue ⬜

Projet : implémenter les 3 structures from scratch en C

### C-16 — Hash table ⬜

Projet : hash table avec gestion des collisions (chaining)

### C-17 — Binary tree, BST ⬜

Projet : BST avec insert, search, delete, traversal

### C-18 — Sorting algorithms ⬜

Projet : quicksort, mergesort, heapsort — comparer les performances

---

## Phase 5 — Linux Kernel

> Le chemin vers le développement noyau Linux.

### C-19 — Kernel modules ⬜

Concepts :
- `module_init`, `module_exit`
- `insmod`, `rmmod`, `lsmod`
- `dmesg` pour les logs kernel
- Espace utilisateur vs espace noyau

```c
#include <linux/module.h>
#include <linux/kernel.h>

static int __init hello_init(void) {
    printk(KERN_INFO "Hello kernel!\n");
    return 0;
}

static void __exit hello_exit(void) {
    printk(KERN_INFO "Goodbye kernel!\n");
}

module_init(hello_init);
module_exit(hello_exit);
MODULE_LICENSE("GPL");
```

Projet : module kernel "Hello World"

---

### C-20 — Character device driver ⬜

Concepts :
- `register_chrdev`, `unregister_chrdev`
- `file_operations` : `open`, `read`, `write`, `release`
- Major/minor numbers
- `/dev/` entries

Projet : device driver qui expose `/dev/mydevice` en lecture/écriture

---

### C-21 — Kernel memory ⬜

Concepts :
- `kmalloc`, `kfree`, `vmalloc`
- Kernel vs userspace memory
- `copy_to_user`, `copy_from_user`
- Memory zones : DMA, NORMAL, HIGHMEM

Projet : module avec allocation mémoire kernel dynamique

---

### C-22 — Proc filesystem ⬜

Concepts :
- Créer des entrées dans `/proc`
- `proc_create`, `proc_remove`
- Exposer des informations kernel en userspace

Projet : `/proc/sysinfo` — exposer des stats système custom

---

### C-23 — Interrupts et timers kernel ⬜

Concepts :
- `request_irq`, `free_irq`
- Softirqs et tasklets
- Kernel timers : `timer_setup`, `mod_timer`
- `hrtimer` — high resolution timers

Projet : timer kernel qui log dans dmesg toutes les secondes

---

### C-24 — Contribuer au kernel Linux ⬜

Concepts :
- Coding style kernel Linux (`checkpatch.pl`)
- Git workflow kernel (`git format-patch`, `git send-email`)
- Mailing lists kernel (LKML)
- Drivers staging : `drivers/staging/` — meilleur endroit pour commencer

Ressources :
- `Documentation/process/submitting-patches.rst`
- `Documentation/process/coding-style.rst`
- kernelnewbies.org

Projet : soumettre un patch de nettoyage dans `drivers/staging/`

---

## Outils essentiels

```bash
# Compiler
gcc -Wall -Wextra -g -o prog prog.c

# Compiler avec sanitizers (détecter bugs runtime)
gcc -fsanitize=address,undefined -o prog prog.c

# Debugger
gdb ./prog

# Fuites mémoire
valgrind --leak-check=full ./prog

# Tracer les syscalls
strace ./prog

# Tracer les appels de bibliothèques
ltrace ./prog

# Build system
make

# Compiler un module kernel
make -C /lib/modules/$(uname -r)/build M=$(pwd) modules
```

---

## Lien avec les objectifs career

| Rôle | Phases C requises |
|------|------------------|
| Systems Engineer | Phase 1 + 2 + 3 |
| SRE / Platform Engineer | Phase 1 + 2 + 3 + 4 |
| Linux Kernel Developer | Toutes les phases (1 → 5) |
